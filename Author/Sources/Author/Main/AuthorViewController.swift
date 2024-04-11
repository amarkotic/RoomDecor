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
        mockData()
    }

    private func bindViews() {}

    private func mockData() {
        guard let mockImage = UIImage(named: BundleImage.author.rawValue, in: Bundle.module, with: nil) else { return }
        publishedProjectsList.set(
            viewModel:
                ProjectListModel(
                    title: "Published projects",
                    description: "Some of the apps I've collaborated on, which got published to App Store",
                    items: [
                        ProjectModel(title: "antonio", description: "iOS developer", image: mockImage),
                        ProjectModel(title: "antonio2", description: "iOS developer", image: mockImage),
                        ProjectModel(title: "antonio3", description: "iOS developer", image: mockImage)]))

        notableProjectsList.set(
            viewModel:
                ProjectListModel(
                    title: "Notable projects",
                    description: "Side projects used to learn a new skill",
                    items: [
                        ProjectModel(title: "antonio", description: "iOS developer", image: mockImage),
                        ProjectModel(title: "antonio2", description: "iOS developer", image: mockImage),
                        ProjectModel(title: "antonio3", description: "iOS developer", image: mockImage)]))
    }

}
