import Combine
import UIKit
import CoreUi

public class AuthorViewController: UIViewController {

    let defaultPadding: CGFloat = 16

    var scrollView: UIScrollView!
    var contentView: UIView!
    var stackView: UIStackView!
    var headerView: HeaderView!
    var dividerView: DividerView!
    var projectsList: ProjectsListView!

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
