import Combine
import UIKit

public class HomeViewController: UIViewController {

    let buttonSize = CGSize(width: 120, height: 40)

    var containerView: UIStackView!
    var addVirtualObjectButton: UIButton!
    var create3DModelButton: UIButton!

    private var disposables = Set<AnyCancellable>()

    public override func viewDidLoad() {
        super.viewDidLoad()

        buildViews()
        bindViews()
    }

    private func bindViews() {
        addVirtualObjectButton
            .throttledTap()
            .sink { [weak self] _ in
                self?.navigationController?.pushViewController(Create3DModelViewController(), animated: true)
            }
            .store(in: &disposables)

        create3DModelButton
            .throttledTap()
            .sink { [weak self] _ in
                self?.navigationController?.pushViewController(Add3DObjectsViewController(), animated: true)
            }
            .store(in: &disposables)
    }

}
