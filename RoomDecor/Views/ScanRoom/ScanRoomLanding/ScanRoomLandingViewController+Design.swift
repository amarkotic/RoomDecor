import UIKit
import RoomPlan
import SnapKit

extension ScanRoomLandingViewController {

    func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }

    public func createViews() {
        navBarView = NavBarView()
        view.addSubview(navBarView)

        startRoomScanButton = UIButton()
        view.addSubview(startRoomScanButton)

        view.bringSubviewToFront(navBarView)
    }

    public func styleViews() {
        view.backgroundColor = .white

        navBarView.set(title: LocalizableStrings.scanTheRoom.localized)
        navigationController?.setNavigationBarHidden(true, animated: false)

        startRoomScanButton.setTitle(LocalizableStrings.start.localized, for: .normal)
        startRoomScanButton.setTitleColor(.white, for: .normal)
        startRoomScanButton.backgroundColor = .black
        startRoomScanButton.layer.cornerRadius = 4
    }

    public func defineLayoutForViews() {
        navBarView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(60)
        }

        startRoomScanButton.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview().inset(30)
            $0.height.equalTo(startButtonHeight)
        }
    }

}
