import UIKit
import RoomPlan
import SnapKit

extension AddVirtualObjectLandingViewController {

    func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }

    public func createViews() {
        switchModuleIcon = SwitchModuleIcon()
        view.addSubview(switchModuleIcon)

        startButton = UIButton()
        view.addSubview(startButton)
    }

    public func styleViews() {
        view.backgroundColor = .green

        startButton.setTitle(LocalizableStrings.share.localized, for: .normal)
        startButton.setTitleColor(.white, for: .normal)
        startButton.backgroundColor = .black
        startButton.layer.cornerRadius = 4
    }

    public func defineLayoutForViews() {
        switchModuleIcon.snp.makeConstraints {
            $0.top.equalToSuperview().inset(70)
            $0.trailing.equalToSuperview().inset(30)
        }

        startButton.snp.makeConstraints {
            $0.bottom.leading.equalToSuperview().inset(30)
            $0.size.equalTo(startButtonSize)
        }
    }

}
