import Combine
import UIKit
import Core
import CoreUi

class ProjectsListView: UIView {

    private typealias DataSource = UICollectionViewDiffableDataSource<Section, ProjectModel>
    private typealias DataSourceSnapshot = NSDiffableDataSourceSnapshot<Section, ProjectModel>

    var model: ProjectListModel!

    let defaultPadding: CGFloat = 8
    let defaultSectionInsets: UIEdgeInsets = .insets(vertical: 16, horizontal: 16)

    var stackView: UIStackView!
    var textStackView: UIStackView!
    var titleLabel: UILabel!
    var descriptionLabel: UILabel!
    var collectionView: UICollectionView!

    private var disposables = Set<AnyCancellable>()
    private var dataSource: DataSource!

    private let selectedItemSubject = PassthroughSubject<ProjectModel, Never>()

    var itemSelected: AnyPublisher<ProjectModel, Never> {
        selectedItemSubject
            .eraseToAnyPublisher()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        buildViews()
        makeDataSource()
        bindViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(viewModel: ProjectListModel) {
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.description
        updateSnapshot(items: viewModel.items)
    }

    private func makeDataSource() {
        dataSource = DataSource(
            collectionView: collectionView,
            cellProvider: { (collectionView, indexPath, item) -> UICollectionViewCell? in
                guard
                    let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: ProjectCell.reuseIdentifier,
                        for: indexPath) as? ProjectCell
                else { return nil }

                cell.set(viewModel: item)

                cell
                    .throttledTap()
                    .sink { [weak self] _ in
                        self?.selectedItemSubject.send(item)
                    }
                    .store(in: &cell.disposables)

                return cell
            })
    }

    private func bindViews() {
    }

    private func updateSnapshot(items: [ProjectModel]) {
        var snapshot = DataSourceSnapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(items)
        dataSource.apply(snapshot, animatingDifferences: true)
    }

}

extension ProjectsListView: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = dataSource.itemIdentifier(for: indexPath) else { return }

        selectedItemSubject.send(item)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return ProjectCell.cellSize
    }

}
