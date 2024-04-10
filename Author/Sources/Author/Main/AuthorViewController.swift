import Combine
import UIKit

public class AuthorViewController: UIViewController {

    let defaultPadding: CGFloat = 16

    private var disposables = Set<AnyCancellable>()
    private let presenter: AuthorPresenter!

    public init(presenter: AuthorPresenter) {
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

    private func bindViews() {

    }

}
