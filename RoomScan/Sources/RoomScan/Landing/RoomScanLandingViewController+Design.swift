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

        topDivider = DividerView()
        view.addSubview(topDivider)

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: makeCollectionViewLayout())
        collectionView.register(RoomScanCell.self, forCellWithReuseIdentifier: RoomScanCell.reuseIdentifier)
        collectionView.delegate = self
        view.addSubview(collectionView)

        startScanView = UIImageView()
        view.addSubview(startScanView)

        notificationView = NotificationView()
        view.addSubview(notificationView)

        bottomDivider = DividerView()
        view.addSubview(bottomDivider)

        startRoomScanButton = UIButton()
        view.addSubview(startRoomScanButton)

        loadingIndicator = UIActivityIndicatorView(style: .large)
        startRoomScanButton.addSubview(loadingIndicator)

        splashView = SplashView()
        view.addSubview(splashView)
    }

    public func styleViews() {
        view.backgroundColor = .white

        navBarView.set(title: LocalizableStrings.scanTheRoom.localized)
        navigationController?.setNavigationBarHidden(true, animated: false)

        collectionView.backgroundColor = .white
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isHidden = false

        startScanView.image = UIImage(named: BundleImage.arrowDown.rawValue, in: .module, with: nil)
        startScanView.contentMode = .scaleAspectFit
        startScanView.isHidden = !supportsLidar

        startRoomScanButton.setTitle(CoreUi.LocalizableStrings.start.localized, for: .normal)
        startRoomScanButton.setTitleColor(.white, for: .normal)
        startRoomScanButton.backgroundColor = .black
        startRoomScanButton.roundAllCorners(withRadius: cornerRadius)
        startRoomScanButton.isHidden = !supportsLidar

        notificationView.isHidden = supportsLidar

        bottomDivider.isHidden = !supportsLidar

        loadingIndicator.isHidden = true

        splashView.isHidden = true
    }

    public func defineLayoutForViews() {
        navBarView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(defaultPadding * 2)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(navBarHeight)
        }

        topDivider.snp.makeConstraints {
            $0.top.equalTo(navBarView.snp.bottom).offset(defaultPadding)
            $0.leading.trailing.equalToSuperview()
        }

        collectionView.snp.makeConstraints {
            $0.top.equalTo(topDivider.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }

        startScanView.snp.makeConstraints {
            $0.size.equalTo(arrowImageSize)
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(bottomDivider.snp.top)
        }

        notificationView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(defaultPadding * 4)
            $0.top.equalTo(topDivider.snp.bottom).offset(defaultPadding * 4)
        }

        bottomDivider.snp.makeConstraints {
            $0.top.equalTo(collectionView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }

        startRoomScanButton.snp.makeConstraints {
            $0.top.equalTo(bottomDivider.snp.bottom).offset(defaultPadding * 2)
            $0.bottom.leading.trailing.equalToSuperview().inset(defaultPadding * 4)
            $0.height.equalTo(startButtonHeight)
        }

        loadingIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
        }

        splashView.snp.makeConstraints {
            $0.edges.equalToSuperview()
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
