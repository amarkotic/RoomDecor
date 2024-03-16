import ARKit
import UIKit
import SnapKit
import CoreUi

extension VirtualObjectViewController {

    func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }

    public func createViews() {
        sceneView = ARSCNView()
        sceneView.setUp(session)
        view.addSubview(sceneView)

        virtualObjectButton = UIButton()
        view.addSubview(virtualObjectButton)
    }

    public func styleViews() {
        navigationController?.setNavigationBarHidden(false, animated: false)

        virtualObjectButton.setTitle(LocalizableStrings.addVirtualObject.localized, for: .normal)
        virtualObjectButton.backgroundColor = .systemBlue
    }

    public func defineLayoutForViews() {
        sceneView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        virtualObjectButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(20)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(buttonSize)
        }
    }

}
