import UIKit
import RoomPlan
import SnapKit
import CoreUi

extension VirtualObjectLandingViewController {

    func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }

    public func createViews() {
        navBarView = NavBarView()
        view.addSubview(navBarView)

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: makeCollectionViewLayout())
        collectionView.register(VirtualObjectCell.self, forCellWithReuseIdentifier: VirtualObjectCell.reuseIdentifier)
        collectionView.delegate = self
        view.addSubview(collectionView)

        view.bringSubviewToFront(navBarView)
    }

    public func styleViews() {
        view.backgroundColor = .white

        navBarView.set(title: LocalizableStrings.addVirtualObject.localized)
        navBarView.backgroundColor = .clear
        navigationController?.setNavigationBarHidden(true, animated: false)

        collectionView.backgroundColor = .lightGray
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isHidden = false
    }

    public func defineLayoutForViews() {
        navBarView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(60)
        }

        collectionView.snp.makeConstraints {
            $0.top.equalTo(navBarView.snp.bottom).offset(24)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }

    private func makeCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = .init(top: 24, left: 16, bottom: 24, right: 16)
        layout.minimumLineSpacing = 16
        return layout
    }

}
