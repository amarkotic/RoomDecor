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

        startButton = UIButton()
        view.addSubview(startButton)

        view.bringSubviewToFront(navBarView)
    }

    public func styleViews() {
        view.backgroundColor = .white

        navBarView.set(title: LocalizableStrings.addVirtualObject.localized)
        navigationController?.setNavigationBarHidden(true, animated: false)

        startButton.setTitle(LocalizableStrings.start.localized, for: .normal)
        startButton.setTitleColor(.white, for: .normal)
        startButton.backgroundColor = .black
        startButton.layer.cornerRadius = 4
    }

    public func defineLayoutForViews() {
        navBarView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(60)
        }

        startButton.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview().inset(30)
            $0.height.equalTo(startButtonHeight)
        }
    }

}
