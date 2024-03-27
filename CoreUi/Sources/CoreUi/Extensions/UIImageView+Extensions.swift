import UIKit
import SceneKit

public extension UIImageView {

    func load3DModelThumbnail(from url: URL) {
        guard let scene = try? SCNScene(url: url, options: nil) else {
            print("Failed to load model")
            return
        }

        let sceneView = SCNView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        sceneView.scene = scene

        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 15)
        scene.rootNode.addChildNode(cameraNode)

        sceneView.backgroundColor = .clear
        sceneView.antialiasingMode = .multisampling4X
        sceneView.autoenablesDefaultLighting = true

        DispatchQueue.main.async {
            self.image = sceneView.snapshot()
        }
    }

}
