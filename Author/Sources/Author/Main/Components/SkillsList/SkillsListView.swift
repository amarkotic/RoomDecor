import Combine
import UIKit
import Core
import CoreUi

class SkillsListView: UIView, UICollectionViewDelegate {

    private typealias DataSource = UICollectionViewDiffableDataSource<Section, SkillModel>
    private typealias DataSourceSnapshot = NSDiffableDataSourceSnapshot<Section, SkillModel>

    let cellHeight: CGFloat = 40
    let estimatedCellWidth: CGFloat = 64
    let cellSpacing: CGFloat = 7

    var model: SkillListModel

    let defaultPadding: CGFloat = 8
    let defaultSectionInsets: UIEdgeInsets = .insets(vertical: 16, horizontal: 16)

    var titleLabel: UILabel!
    var collectionView: UICollectionView!

    private var disposables = Set<AnyCancellable>()
    private var dataSource: DataSource!

    public init(viewModel: SkillListModel) {
        self.model = viewModel

        super.init(frame: .zero)

        buildViews()
        makeDataSource()
        titleLabel.text = viewModel.title
        updateSnapshot(items: viewModel.skills)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func makeDataSource() {
        dataSource = DataSource(
            collectionView: collectionView,
            cellProvider: { (collectionView, indexPath, item) -> UICollectionViewCell? in
                guard
                    let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: SkillCell.reuseIdentifier,
                        for: indexPath) as? SkillCell
                else { return nil }

                cell.set(viewModel: item)

                return cell
            })
    }

    private func updateSnapshot(items: [SkillModel]) {
        var snapshot = DataSourceSnapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(items)
        dataSource.apply(snapshot, animatingDifferences: true)
    }

}
