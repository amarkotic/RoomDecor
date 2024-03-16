import UIKit
import Combine
import Core
import CoreUi

public class RoomScanLandingViewController: UIViewController {

    let startButtonHeight: CGFloat = 60

    var navBarView: NavBarView!
    var startRoomScanButton: UIButton!

    private var disposables = Set<AnyCancellable>()
    private var presenter: RoomScanLandingPresenter!

    public override func viewDidLoad() {
        super.viewDidLoad()

        buildViews()
        bindViews()
    }

    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public init(presenter: RoomScanLandingPresenter) {
        self.presenter = presenter

        super.init(nibName: nil, bundle: nil)
    }

    private func bindViews() {
        navBarView
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
