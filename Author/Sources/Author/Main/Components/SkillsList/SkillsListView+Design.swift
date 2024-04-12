import UIKit
import SnapKit
import CoreUi

extension SkillsListView {

    func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }

    func createViews() {
        titleLabel = UILabel()
        addSubview(titleLabel)

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: makeCollectionViewLayout())
        collectionView.delegate = self
        collectionView.register(SkillCell.self, forCellWithReuseIdentifier: SkillCell.reuseIdentifier)
        addSubview(collectionView)
    }

    func styleViews() {
        titleLabel.textColor = .black
        titleLabel.font = UIFont(with: .futura, size: 18)

        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isScrollEnabled = true
    }

    func defineLayoutForViews() {
        titleLabel.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview().inset(defaultPadding * 2)
        }

        let height: CGFloat = (cellHeight + defaultPadding) * CGFloat(model.skills.count / 3)
        collectionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(defaultPadding * 2)
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.greaterThanOrEqualTo(height)
        }
    }

    private func makeCollectionViewLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .estimated(estimatedCellWidth),
            heightDimension: .absolute(cellHeight))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(cellHeight))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .fixed(cellSpacing)

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 12)
        section.interGroupSpacing = 8

        return UICollectionViewCompositionalLayout(section: section)
    }

}
