import Combine
import RoomPlan
import UIKit

public class RoomScanViewController: UIViewController {

    let defaultPadding: CGFloat = 16
    let cornerRadius: CGFloat = 4
    let buttonSize = CGSize(width: 80, height: 60)

    var roomCaptureView: RoomCaptureView!
    var stackView: UIStackView!
    var saveButton: UIButton!
    var shareButton: UIButton!

    private var disposables = Set<AnyCancellable>()
    private let presenter: RoomScanPresenter!
    private var capturedRoom: CapturedRoom?

    public init(presenter: RoomScanPresenter) {
        self.presenter = presenter

        super.init(nibName: nil, bundle: nil)
    }

    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()

        buildViews()
        bindViews()
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.navigationBar.isHidden = false
    }

    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        startSession()
    }

    private func bindViews() {
        presenter
            .$canExport
            .sink { [weak self] canExport in
                self?.shareButton.isHidden = !canExport
            }
            .store(in: &disposables)

        saveButton
            .throttledTap()
            .sink { [weak self] _ in
                self?.saveRoomModel()
            }
            .store(in: &disposables)

        shareButton
            .throttledTap()
            .sink { [weak self] _ in
                self?.exportRoomModel()
            }
            .store(in: &disposables)
    }

    private func startSession() {
        let sessionConfig = RoomCaptureSession.Configuration()
        roomCaptureView?.captureSession.run(configuration: sessionConfig)
    }

    private func saveRoomModel() {
        do {
            let url = presenter.exportUrl
            try capturedRoom?.export(to: url)
        } catch {
            print(error.localizedDescription)
        }
    }

    private func exportRoomModel() {
        do {
            let url = presenter.exportUrl
            try capturedRoom?.export(to: url)
            presenter.presentShareSheet(for: [url])
        } catch {
            print(error.localizedDescription)
        }
    }

}

// MARK: - RoomCaptureSessionDelegate
extension RoomScanViewController: RoomCaptureSessionDelegate {

    public func captureSession(_ session: RoomCaptureSession, didUpdate room: CapturedRoom) {
        capturedRoom = room
        DispatchQueue.main.async {
            self.presenter.canExport = true
        }
    }

}
