import Combine
import RoomPlan
import UIKit

public class RoomScanViewController: UIViewController {

    let defaultPadding: CGFloat = 16
    let cornerRadius: CGFloat = 4
    let buttonSize = CGSize(width: 80, height: 60)

    let sessionConfig: RoomCaptureSession.Configuration

    var roomCaptureView: RoomCaptureView!
    var saveButton: UIButton!
    var saveLoadingIndicator: UIActivityIndicatorView!
    var shareButton: UIButton!
    var shareLoadingIndicator: UIActivityIndicatorView!

    private var disposables = Set<AnyCancellable>()
    private let presenter: RoomScanPresenter!
    private var capturedRoom: CapturedRoom?

    private var buttonTappedSubject = PassthroughSubject<ActionType, Never>()

    var buttonTapped: AnyPublisher<ActionType, Never> {
        buttonTappedSubject
            .delay(for: .milliseconds(100), scheduler: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

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
            .$isReadyToSave
            .sink { [weak self] isReadyToSave in
                self?.saveButton.isHidden = !isReadyToSave
            }
            .store(in: &disposables)

        saveButton
            .throttledTap()
            .sink { [weak self] _ in
                guard let self else { return }

                self.showLoader(for: .save)
                self.buttonTappedSubject.send(.save)
            }
            .store(in: &disposables)

        shareButton
            .throttledTap()
            .sink { [weak self] _ in
                guard let self else { return }

                self.showLoader(for: .share)
                self.buttonTappedSubject.send(.share)
            }
            .store(in: &disposables)

        buttonTapped
            .sink { [weak self] type in
                guard let self else { return }

                switch type {
                case .save:
                    self.saveTapped()
                case .share:
                    self.shareTapped()
                }
            }
            .store(in: &disposables)
    }

    private func startSession() {
        roomCaptureView.captureSession.run(configuration: sessionConfig)
    }

    private func stopSession() {
        roomCaptureView.captureSession.stop()
    }

    private func saveTapped() {
        saveRoomScan()
        stopSession()
        saveButton.isHidden = true
        hideLoader(for: .save)
    }

    private func shareTapped() {
        presenter.presentShareSheet()
        hideLoader(for: .share)
    }

    private func saveRoomScan() {
        do {
            let url = presenter.exportUrl
            try capturedRoom?.export(to: url)
        } catch {
            presenter.showErrorPopup(for: .save)
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

    private func hideLoader(for action: ActionType) {
        switch action {
        case .save:
            self.saveLoadingIndicator.isHidden = true
            self.saveLoadingIndicator.stopAnimating()
            self.saveButton.titleLabel?.isHidden = false
        case .share:
            self.shareLoadingIndicator.isHidden = true
            self.shareLoadingIndicator.stopAnimating()
            self.shareButton.titleLabel?.isHidden = false
        }
    }

}

// MARK: - RoomCaptureSessionDelegate
extension RoomScanViewController: RoomCaptureSessionDelegate {

    public func captureSession(_ session: RoomCaptureSession, didUpdate room: CapturedRoom) {
        capturedRoom = room
        DispatchQueue.main.async {
            self.presenter.isReadyToSave = true
        }
    }

    public func captureSession(_ session: RoomCaptureSession, didEndWith data: CapturedRoomData, error: (any Error)?) {
        DispatchQueue.main.async {
            guard error == nil else {
                self.presenter.showErrorPopup(for: .session)
                return
            }

            UIView.animate(withDuration: 0.2, delay: 1.5) {
                self.shareButton.layer.opacity = 1
            }
        }
    }

}
