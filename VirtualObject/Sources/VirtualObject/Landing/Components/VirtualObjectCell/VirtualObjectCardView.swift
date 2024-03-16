import UIKit
import SceneKit
import SnapKit

class VirtualObjectCardView: UIView {

    var stackView: UIStackView!
    var imageView: UIImageView!
    var titleLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)

        buildViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(type: VirtualObjectType) {
        titleLabel.text = type.title
        load3DModelThumbnail(fileName: type.rawValue)
    }

}

extension VirtualObjectCardView {

    func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }

    func createViews() {
        stackView = UIStackView()
        addSubview(stackView)

        imageView = UIImageView()
        stackView.addArrangedSubview(imageView)

        titleLabel = UILabel()
        stackView.addArrangedSubview(titleLabel)
    }

    func styleViews() {
        backgroundColor = .white
        layer.cornerRadius = 16
        clipsToBounds = true
        layer.borderWidth = 2
        layer.borderColor = UIColor.black.cgColor

        stackView.axis = .vertical
        stackView.alignment = .center

        imageView.contentMode = .scaleAspectFit

        titleLabel.textColor = .black
        titleLabel.font = UIFont(name: "Futura", size: 18)
    }

    func defineLayoutForViews() {
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(16)
        }
    }

}

// Create a thumbnail from usdz items
extension VirtualObjectCardView {

    private func load3DModelThumbnail(fileName: String) {
        guard let url = Bundle.module.url(forResource: fileName, withExtension: "usdz") else {
            print("Failed to find URL for model")
            return
        }

        guard let scene = try? SCNScene(url: url) else {
            print("Failed to load model")
            return
        }

        let sceneView = SCNView(frame: CGRect(x: 0, y: 0, width: 1024, height: 1024))
        sceneView.scene = scene

        // Configure the camera
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 15)
        scene.rootNode.addChildNode(cameraNode)

        // Configure the sceneView
        sceneView.backgroundColor = .clear
        sceneView.antialiasingMode = .multisampling4X
        sceneView.autoenablesDefaultLighting = true

        // Attach the snapshot from sceneView to card's imageView
        let image = sceneView.snapshot()
        imageView.image = image
    }

}
