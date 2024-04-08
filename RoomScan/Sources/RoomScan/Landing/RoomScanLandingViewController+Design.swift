import UIKit
import RoomPlan
import SnapKit
import CoreUi

extension RoomScanLandingViewController {

    func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }

    public func createViews() {
        navBarView = NavBarView()
        view.addSubview(navBarView)

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: makeCollectionViewLayout())
        collectionView.register(RoomScanCell.self, forCellWithReuseIdentifier: RoomScanCell.reuseIdentifier)
        collectionView.delegate = self
        view.addSubview(collectionView)

        startRoomScanButton = UIButton()
        view.addSubview(startRoomScanButton)

        loadingIndicator = UIActivityIndicatorView(style: .large)
        startRoomScanButton.addSubview(loadingIndicator)
    }

    public func styleViews() {
        view.backgroundColor = .white

        navBarView.set(title: LocalizableStrings.scanTheRoom.localized)
        navigationController?.setNavigationBarHidden(true, animated: false)

        collectionView.backgroundColor = .lightGray
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isHidden = false

        startRoomScanButton.setTitle(CoreUi.LocalizableStrings.start.localized, for: .normal)
        startRoomScanButton.setTitleColor(.white, for: .normal)
        startRoomScanButton.backgroundColor = .black
        startRoomScanButton.roundAllCorners(withRadius: cornerRadius)

        loadingIndicator.isHidden = true
    }

    public func defineLayoutForViews() {
        navBarView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(defaultPadding * 2)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(navBarHeight)
        }

        collectionView.snp.makeConstraints {
            $0.top.equalTo(navBarView.snp.bottom).offset(defaultPadding * 2)
            $0.leading.trailing.equalToSuperview()
        }

        startRoomScanButton.snp.makeConstraints {
            $0.top.equalTo(collectionView.snp.bottom).offset(defaultPadding)
            $0.bottom.leading.trailing.equalToSuperview().inset(defaultPadding * 4)
            $0.height.equalTo(startButtonHeight)
        }

        loadingIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }

    private func makeCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = .insets(vertical: 24, horizontal: 16)
        layout.minimumLineSpacing = 16
        return layout
    }

}
