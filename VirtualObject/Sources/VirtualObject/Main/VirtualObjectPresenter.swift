import ARKit
import Foundation
import SceneKit
import Core

public class VirtualObjectPresenter {

    private let appRouter: VirtualObjectRouterProtocol
    private let type: VirtualObjectType

    public init(appRouter: VirtualObjectRouterProtocol, type: VirtualObjectType) {
        self.appRouter = appRouter
        self.type = type
    }

    private var modelCache: [String: SCNNode] = [:]

    func addVirtualObject(screenCenter: CGPoint?, sceneView: ARSCNView) {
        guard
            let center = screenCenter,
            let query = sceneView.raycastQuery(from: center, allowing: .estimatedPlane, alignment: .horizontal),
            let transform = sceneView.session.raycast(query).first?.worldTransform,
            let objectNode = loadVirtualObject(named: type.rawValue)
        else { return }

        let position = SCNVector3(transform.columns.3.x, transform.columns.3.y, transform.columns.3.z)
        objectNode.position = position
        objectNode.scale = SCNVector3(0.01, 0.01, 0.01)

        objectNode.enumerateChildNodes { (node, _) in
            node.castsShadow = true
            node.geometry?.firstMaterial?.lightingModel = .physicallyBased
        }

        sceneView.autoenablesDefaultLighting = true
        sceneView.automaticallyUpdatesLighting = true
        sceneView.scene.rootNode.castsShadow = true
        sceneView.scene.rootNode.addChildNode(objectNode)
    }

    private func loadVirtualObject(named modelName: String, type: FileType = .usdz) -> SCNNode? {
        if let cachedNode = modelCache[modelName] {
            return cachedNode.clone() // Use clone to duplicate the node if needed
        }

        guard
            let url = Bundle.module.url(forResource: modelName, withExtension: type.fileExtension),
            let scene = try? SCNScene(url: url)
        else {
            showErrorPopup(for: .loadObject)
            return nil
        }

        let modelNode = scene.rootNode.childNodes.first
        modelCache[modelName] = modelNode // Cache the loaded model
        return modelNode?.clone() // Return a clone if you will add this to the scene multiple times
    }

    func showErrorPopup(for type: VirtualObjectErrorType) {
        appRouter.showErrorPopup(for: type)
    }

}
