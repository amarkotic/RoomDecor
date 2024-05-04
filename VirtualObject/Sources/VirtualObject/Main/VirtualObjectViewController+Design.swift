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
        sceneView.delegate = self

        sightImageView = UIImageView()
        view.addSubview(sightImageView)

        infoView = InfoView()
        view.addSubview(infoView)

        virtualObjectButton = UIButton()
        view.addSubview(virtualObjectButton)
    }

    public func styleViews() {
        navigationController?.setNavigationBarHidden(false, animated: false)

        sightImageView.image = UIImage(named: BundleImage.sight.rawValue, in: .module, with: nil)
        sightImageView.contentMode = .scaleAspectFill

        infoView.set(title: "Point at a horizontal plane")

        virtualObjectButton.setTitle(LocalizableStrings.addVirtualObject.localized, for: .normal)
        virtualObjectButton.setTitleColor(.white, for: .normal)
        virtualObjectButton.backgroundColor = .black
        virtualObjectButton.roundAllCorners(withRadius: cornerRadius)
    }

    public func defineLayoutForViews() {
        sceneView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        sightImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(sightImageSize)
        }

        infoView.snp.makeConstraints {
            $0.bottom.equalTo(virtualObjectButton.snp.top).offset(-defaultPadding)
            $0.leading.trailing.equalToSuperview().inset(defaultPadding * 2)
        }

        virtualObjectButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(20)
            $0.leading.trailing.equalToSuperview().inset(defaultPadding * 2)
            $0.height.equalTo(buttonHeight)
        }
    }

}
