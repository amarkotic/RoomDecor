import Combine
import RoomPlan
import UIKit

public class RoomScanViewController: UIViewController {

    let defaultPadding: CGFloat = 16
    let cornerRadius: CGFloat = 4
    let buttonSize = CGSize(width: 80, height: 60)

    let sessionConfig: RoomCaptureSession.Configuration

    var roomCaptureView: RoomCaptureView!
    var stackView: UIStackView!
    var saveButton: UIButton!
    var saveLoadingIndicator: UIActivityIndicatorView!
    var shareButton: UIButton!
    var shareLoadingIndicator: UIActivityIndicatorView!

    private var disposables = Set<AnyCancellable>()
    private let presenter: RoomScanPresenter!
    private var capturedRoom: CapturedRoom?

    public init(presenter: RoomScanPresenter) {
        self.presenter = presenter
        self.sessionConfig = RoomCaptureSession.Configuration()

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
                self?.stackView.isHidden = !canExport
            }
            .store(in: &disposables)

        saveButton
            .throttledTap()
            .sink { [weak self] _ in
                guard let self else { return }

                self.showLoader(for: .save)

                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    self.saveRoomModel()
                }
            }
            .store(in: &disposables)

        shareButton
            .throttledTap()
            .sink { [weak self] _ in
                guard let self else { return }

                self.showLoader(for: .share)

                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    self.shareRoomModel()
                }
            }
            .store(in: &disposables)
    }

    private func startSession() {
        roomCaptureView?.captureSession.run(configuration: sessionConfig)
    }

    private func stopSession() {
        roomCaptureView.captureSession.stop()
    }

    private func saveRoomModel() {
        do {
            let url = presenter.exportUrl
            stopSession()
            try capturedRoom?.export(to: url)
        } catch {
            print(error.localizedDescription)
        }
        //        hideLoader()
    }

    private func shareRoomModel() {
        do {
            let url = presenter.exportUrl
            try capturedRoom?.export(to: url)
            let backgroundQueue = DispatchQueue(label: "background_queue", qos: .background)

            backgroundQueue.async {[weak self] in
                self?.stopSession()
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.presenter.presentShareSheet(for: [url])
            }
        } catch {
            print(error.localizedDescription)
        }
    }

    private func showLoader(for action: ActionType) {
        switch action {
        case .save:
            self.saveLoadingIndicator.isHidden = false
            self.saveLoadingIndicator.startAnimating()
            self.saveButton.titleLabel?.isHidden = true
        case .share:
            self.shareLoadingIndicator.isHidden = false
            self.shareLoadingIndicator.startAnimating()
            self.shareButton.titleLabel?.isHidden = true
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

    public func captureSession(_ session: RoomCaptureSession, didEndWith data: CapturedRoomData, error: (any Error)?) {
        DispatchQueue.main.async {
            self.stackView.isHidden = true
        }
    }

}
