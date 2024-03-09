import UIKit
import Combine

class ScanRoomLandingViewController: UIViewController {

    let startRoomScanButtonSize = CGSize(width: 80, height: 60)

    var switchModuleIcon: SwitchModuleIcon!
    var startRoomScanButton: UIButton!

    private var disposables = Set<AnyCancellable>()
    private var presenter: ScanRoomLandingPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()

        buildViews()
        bindViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(presenter: ScanRoomLandingPresenter) {
        self.presenter = presenter

        super.init(nibName: nil, bundle: nil)
    }

    private func bindViews() {
        switchModuleIcon
            .iconInteraction
            .sink { [weak self] interaction in
                self?.presenter.switchButtonInteracted(with: interaction)
            }
            .store(in: &disposables)

        startRoomScanButton
            .throttledTap()
            .sink { [weak self] _ in
                self?.presenter.startRoomScanTapped()
            }
            .store(in: &disposables)
    }

}
