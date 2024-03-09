import UIKit
import Combine

class AddVirtualObjectLandingViewController: UIViewController {

    let startButtonHeight: CGFloat = 60

    var navBarView: NavBarView!
    var startButton: UIButton!

    private var disposables = Set<AnyCancellable>()
    private var presenter: AddVirtualObjectLandingPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()

        buildViews()
        bindViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(presenter: AddVirtualObjectLandingPresenter) {
        self.presenter = presenter

        super.init(nibName: nil, bundle: nil)
    }

    private func bindViews() {
        navBarView
            .switchIcon
            .iconInteraction
            .sink { [weak self] interaction in
                self?.presenter.switchButtonInteracted(with: interaction)
            }
            .store(in: &disposables)

        startButton
            .throttledTap()
            .sink { [weak self] _ in
                self?.presenter.startAddVirtualObject()
            }
            .store(in: &disposables)
    }

}
