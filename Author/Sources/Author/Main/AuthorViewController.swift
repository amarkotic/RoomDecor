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
    var publishedProjectsList: ProjectsListView!
    var notableProjectsList: ProjectsListView!

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
        populateCells()
    }

    private func bindViews() {
        publishedProjectsList
            .itemSelected
            .sink { [weak self] model in
                self?.presenter.showWebView(url: model.url)
            }
            .store(in: &disposables)
    }

    private func populateCells() {
        publishedProjectsList.set(viewModel: ProjectListModel.publishedProjectsModel)
        notableProjectsList.set(viewModel: ProjectListModel.notableProjectsModel)
    }

}
