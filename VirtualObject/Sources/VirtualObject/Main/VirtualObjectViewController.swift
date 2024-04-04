import ARKit
import UIKit
import SnapKit
import Combine
import CoreUi

public class VirtualObjectViewController: UIViewController {

    let type: VirtualObjectType
    let session = ARSession()
    let buttonSize = CGSize(width: 200, height: 50)

    var sceneView: ARSCNView!
    var virtualObjectButton: UIButton!

    private var screenCenter: CGPoint?
    private var disposables = Set<AnyCancellable>()
    private var sessionConfig: ARConfiguration = ARWorldTrackingConfiguration()

    public init(type: VirtualObjectType) {
        self.type = type

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()

        buildViews()
        bindViews()
    }

    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        screenCenter = view.bounds.mid
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.navigationBar.isHidden = false
    }

    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        UIApplication.shared.isIdleTimerDisabled = true
        restartPlaneDetection()
    }

    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        session.pause()
    }

    private func restartPlaneDetection() {
        if let worldSessionConfig = sessionConfig as? ARWorldTrackingConfiguration {
            worldSessionConfig.planeDetection = .horizontal
            session.run(worldSessionConfig, options: [.resetTracking, .removeExistingAnchors])
        }
    }

    private func bindViews() {
        virtualObjectButton
            .throttledTap()
            .sink { [weak self] _ in
                self?.virtualObject()
            }
            .store(in: &disposables)
    }

    private func virtualObject() {
        guard
            let centerPoint = screenCenter,
            let hitTestResult = sceneView.hitTest(
                centerPoint,
                types: [.existingPlaneUsingExtent, .estimatedHorizontalPlane]).first,
            let chairNode = loadModel(named: type.rawValue, withExtension: "usdz")
        else {
            print("Hit test failed")
            return
        }

        let transform = hitTestResult.worldTransform
        let position = SCNVector3(transform.columns.3.x, transform.columns.3.y, transform.columns.3.z)
        chairNode.position = position
        chairNode.scale = SCNVector3(0.01, 0.01, 0.01)

        chairNode.enumerateChildNodes { (node, _) in
            node.castsShadow = true
            node.geometry?.firstMaterial?.lightingModel = .physicallyBased
        }

        sceneView.autoenablesDefaultLighting = true
        sceneView.automaticallyUpdatesLighting = true
        sceneView.scene.rootNode.castsShadow = true

        sceneView.scene.rootNode.addChildNode(chairNode)
    }

    // Preload or cache the models if necessary to avoid reloading them multiple times
    private var modelCache: [String: SCNNode] = [:]

    private func loadModel(named modelName: String, withExtension fileExtension: String) -> SCNNode? {
        if let cachedNode = modelCache[modelName] {
            return cachedNode.clone() // Use clone to duplicate the node if needed
        }

        guard let url = Bundle.module.url(forResource: modelName, withExtension: fileExtension) else {
            print("Failed to find URL for model \(modelName) with extension \(fileExtension)")
            return nil
        }

        guard let scene = try? SCNScene(url: url) else {
            print("Failed to load model \(modelName) from URL \(url)")
            return nil
        }

        let modelNode = scene.rootNode.childNodes.first
        modelCache[modelName] = modelNode // Cache the loaded model
        return modelNode?.clone() // Return a clone if you will add this to the scene multiple times
    }

}
