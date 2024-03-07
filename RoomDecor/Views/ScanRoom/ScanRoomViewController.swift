import Combine
import RoomPlan
import UIKit

public class ScanRoomViewController: UIViewController {

    let shareButtonSize = CGSize(width: 80, height: 60)

    var roomCaptureView: RoomCaptureView!
    var shareButton: UIButton!
    var viewModel: ScanRoomViewModel

    private var disposables = Set<AnyCancellable>()
    private var capturedRoom: CapturedRoom?

    init(viewModel: ScanRoomViewModel) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()

        buildViews()
        bindViews()
    }

    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        viewModel.actions.send(.startSession)
    }

    private func bindViews() {
        viewModel
            .actions
            .sink { [weak self] action in
                switch action {
                case .startSession:
                    self?.startSession()
                case .export:
                    self?.export()
                default:
                    return
                }
            }
            .store(in: &disposables)

        viewModel
            .$canExport
            .sink { [weak self] canExport in
                self?.shareButton.isHidden = !canExport
            }
            .store(in: &disposables)

        shareButton
            .throttledTap()
            .sink { [weak self] _ in
                self?.presentShareSheet()
            }
            .store(in: &disposables)
    }

    private func startSession() {
        let sessionConfig = RoomCaptureSession.Configuration()
        roomCaptureView?.captureSession.run(configuration: sessionConfig)
    }

    private func export() {
        do {
            try capturedRoom?.export(to: viewModel.exportUrl)
            viewModel.showShareSheet = true
        } catch {
            print(error.localizedDescription)
        }
    }

    private func presentShareSheet() {
        let items = [viewModel.exportUrl]
        let activityViewController = UIActivityViewController(activityItems: items, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = view
        present(activityViewController, animated: true, completion: nil)
    }

}

// MARK: - RoomCaptureSessionDelegate
extension ScanRoomViewController: RoomCaptureSessionDelegate {

    public func captureSession(_ session: RoomCaptureSession, didUpdate room: CapturedRoom) {
        capturedRoom = room
        DispatchQueue.main.async {
            self.viewModel.canExport = true
        }
    }

}
