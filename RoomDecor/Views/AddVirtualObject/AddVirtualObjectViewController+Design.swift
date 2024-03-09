import ARKit
import UIKit
import SnapKit

extension AddVirtualObjectViewController {

    func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }

    public func createViews() {
        sceneView = ARSCNView()
        sceneView.setUp(session)
        view.addSubview(sceneView)

        addVirtualObjectButton = UIButton()
        view.addSubview(addVirtualObjectButton)

        switchModuleIcon = SwitchModuleIcon()
        view.addSubview(switchModuleIcon)
    }

    public func styleViews() {
        addVirtualObjectButton.setTitle(LocalizableStrings.addVirtualObject.localized, for: .normal)
        addVirtualObjectButton.backgroundColor = .systemBlue
    }

    public func defineLayoutForViews() {
        sceneView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        addVirtualObjectButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(20)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(buttonSize)
        }

        switchModuleIcon.snp.makeConstraints {
            $0.top.equalToSuperview().inset(70)
            $0.trailing.equalToSuperview().inset(30)
        }
    }

}
