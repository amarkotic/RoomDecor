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

        switchButton = UIButton()
        view.addSubview(switchButton)
    }

    public func styleViews() {
        addVirtualObjectButton.setTitle(LocalizableStrings.addVirtualObject.localized, for: .normal)
        addVirtualObjectButton.backgroundColor = .systemBlue

        switchButton.backgroundColor = .lightGray
        switchButton.layer.cornerRadius = 12
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

        switchButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(70)
            $0.trailing.equalToSuperview().inset(30)
            $0.size.equalTo(CGSize(width: 24, height: 24))
        }
    }

}
