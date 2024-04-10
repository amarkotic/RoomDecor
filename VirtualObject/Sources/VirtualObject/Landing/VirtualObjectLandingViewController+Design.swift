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

        dividerView = DividerView()
        view.addSubview(dividerView)

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: makeCollectionViewLayout())
        collectionView.register(VirtualObjectCell.self, forCellWithReuseIdentifier: VirtualObjectCell.reuseIdentifier)
        collectionView.delegate = self
        view.addSubview(collectionView)

        loadingView = UIView()
        view.addSubview(loadingView)

        loadingIndicator = UIActivityIndicatorView(style: .large)
        loadingView.addSubview(loadingIndicator)

        view.bringSubviewToFront(navBarView)
    }

    public func styleViews() {
        view.backgroundColor = .white

        navBarView.set(title: LocalizableStrings.addVirtualObject.localized)
        navBarView.backgroundColor = .clear
        navigationController?.setNavigationBarHidden(true, animated: false)

        collectionView.backgroundColor = .white
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isHidden = false

        loadingView.isHidden = true
        loadingView.backgroundColor = .darkGray
        loadingView.layer.opacity = 0.85
    }

    public func defineLayoutForViews() {
        navBarView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(defaultPadding * 2)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(navBarHeight)
        }

        dividerView.snp.makeConstraints {
            $0.top.equalTo(navBarView.snp.bottom).offset(defaultPadding)
            $0.leading.trailing.equalToSuperview()
        }

        collectionView.snp.makeConstraints {
            $0.top.equalTo(dividerView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }

        loadingView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        loadingIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }

    private func makeCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = .insets(vertical: .padding(withMultiplier: 3), horizontal: .doublePadding)
        layout.minimumLineSpacing = .doublePadding
        return layout
    }

}
