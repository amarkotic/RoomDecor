import Combine
import UIKit

public class HomeViewController: UIViewController {

    let buttonSize = CGSize(width: 120, height: 40)

    var containerView: UIStackView!
    var addVirtualObjectButton: UIButton!
    var create3DModelButton: UIButton!

    private var presenter: HomePresenter!
    private var disposables = Set<AnyCancellable>()

    convenience init(presenter: HomePresenter) {
        self.init()

        self.presenter = presenter
    }

    public override func viewDidLoad() {
        super.viewDidLoad()

        buildViews()
        bindViews()
    }

    private func bindViews() {
        addVirtualObjectButton
            .throttledTap()
            .sink { [weak self] _ in
                self?.presenter.presentAddVirtualObjectViewController()
            }
            .store(in: &disposables)

        create3DModelButton
            .throttledTap()
            .sink { [weak self] _ in
                self?.presenter.presentScanRoomViewController()
            }
            .store(in: &disposables)
    }

}
