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
        textStackView = UIStackView()
        addSubview(textStackView)

        titleLabel = UILabel()
        textStackView.addArrangedSubview(titleLabel)

        descriptionLabel = UILabel()
        textStackView.addArrangedSubview(descriptionLabel)

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: makeCollectionViewLayout())
        collectionView.delegate = self
        collectionView.register(ProjectCell.self, forCellWithReuseIdentifier: ProjectCell.reuseIdentifier)
        addSubview(collectionView)
    }

    func styleViews() {
        backgroundColor = .white

        textStackView.axis = .vertical
        textStackView.spacing = 2
        textStackView.alignment = .leading

        titleLabel.textColor = .black
        titleLabel.font = UIFont(with: .futura, size: 18)

        descriptionLabel.numberOfLines = 0
        descriptionLabel.textColor = .black
        descriptionLabel.font = UIFont(with: .futura, size: 14)

        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isScrollEnabled = true
    }

    func defineLayoutForViews() {
        textStackView.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview().inset(defaultPadding * 2)
        }

        let height: CGFloat = ProjectCell.cellSize.height + defaultSectionInsets.top + defaultSectionInsets.bottom
        collectionView.snp.makeConstraints {
            $0.top.equalTo(textStackView.snp.bottom).offset(defaultPadding)
            $0.leading.trailing.bottom.equalToSuperview()
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
