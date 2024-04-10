import UIKit
import SnapKit
import CoreUi

extension ProjectsListView {

    func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }

    func createViews() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: makeCollectionViewLayout())
        collectionView.delegate = self
        collectionView.register(ProjectCell.self, forCellWithReuseIdentifier: ProjectCell.reuseIdentifier)
        addSubview(collectionView)
    }

    func styleViews() {
        backgroundColor = .white

        collectionView.backgroundColor = .white
        collectionView.showsVerticalScrollIndicator = false
    }

    func defineLayoutForViews() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(height)
        }
    }

    private func makeCollectionViewLayout() -> UICollectionViewLayout {
        let layout = HorizontalPagingLayout(leadingOffset: defaultPadding * 2)
        layout.scrollDirection = .horizontal
        layout.sectionInset = defaultSectionInsets
        layout.itemSize = ProjectCell.cellSize
        layout.minimumLineSpacing = defaultPadding * 2
        return layout
    }

}
