import ARKit
import UIKit
import SnapKit
import Combine

class AddVirtualObjectViewController: UIViewController {

    let session = ARSession()
    let buttonSize = CGSize(width: 200, height: 50)

    var sceneView: ARSCNView!
    var addVirtualObjectButton: UIButton!

    private var screenCenter: CGPoint?
    private var disposables = Set<AnyCancellable>()
    private var sessionConfig: ARConfiguration = ARWorldTrackingConfiguration()

    public override func viewDidLoad() {
        super.viewDidLoad()

        buildViews()
        bindViews()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        screenCenter = view.bounds.mid
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        UIApplication.shared.isIdleTimerDisabled = true
        restartPlaneDetection()
    }

    override func viewWillDisappear(_ animated: Bool) {
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
        addVirtualObjectButton
            .throttledTap()
            .sink { [weak self] _ in
                self?.addVirtualObject()
            }
            .store(in: &disposables)
    }

    private func addVirtualObject() {
        guard
            let centerPoint = screenCenter,
            let hitTestResult = sceneView.hitTest(
                centerPoint,
                types: [.existingPlaneUsingExtent, .estimatedHorizontalPlane]).first,
            let chairNode = loadChairModel()
        else {
            print("Hit test failed")
            return
        }

        let transform = hitTestResult.worldTransform
        let position = SCNVector3(transform.columns.3.x, transform.columns.3.y, transform.columns.3.z)
        chairNode.position = position

        sceneView.scene.rootNode.addChildNode(chairNode)
    }

    private func loadChairModel() -> SCNNode? {
        guard
            let chairScene = SCNScene(named: "Models.scnassets/chair/chair.scn"),
            let chairNode = chairScene.rootNode.childNode(withName: "chair", recursively: true)
        else {
            print("Failed to load chair model")
            return nil
        }

        return chairNode
    }

}
