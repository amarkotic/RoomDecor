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
        switchModuleIcon = SwitchModuleIcon()
        view.addSubview(switchModuleIcon)

        startRoomScanButton = UIButton()
        view.addSubview(startRoomScanButton)
    }

    public func styleViews() {
        view.backgroundColor = .red

        startRoomScanButton.setTitle(LocalizableStrings.share.localized, for: .normal)
        startRoomScanButton.setTitleColor(.white, for: .normal)
        startRoomScanButton.backgroundColor = .black
        startRoomScanButton.layer.cornerRadius = 4
    }

    public func defineLayoutForViews() {
        switchModuleIcon.snp.makeConstraints {
            $0.top.equalToSuperview().inset(70)
            $0.trailing.equalToSuperview().inset(30)
        }

        startRoomScanButton.snp.makeConstraints {
            $0.bottom.leading.equalToSuperview().inset(30)
            $0.size.equalTo(startRoomScanButtonSize)
        }
    }

}
