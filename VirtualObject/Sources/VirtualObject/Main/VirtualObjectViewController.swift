import ARKit
import Combine
import UIKit
import Core
import CoreUi

public class VirtualObjectViewController: UIViewController {

    let type: VirtualObjectType
    let session = ARSession()
    let defaultPadding: CGFloat = 8
    let cornerRadius: CGFloat = 4
    let buttonHeight: CGFloat = 50
    let sightImageSize = CGSize(width: 100, height: 100)

    var sceneView: ARSCNView!
    var sightImageView: UIImageView!
    var infoView: InfoView!
    var virtualObjectButton: UIButton!

    private var screenCenter: CGPoint?
    private var disposables = Set<AnyCancellable>()
    private var sessionConfig: ARConfiguration = ARWorldTrackingConfiguration()
    private var modelCache: [String: SCNNode] = [:]

    private var horizontalPlaneDetectedSubject = PassthroughSubject<Bool, Never>()

    var horizontalPlaneDetected: AnyPublisher<Bool, Never> {
        horizontalPlaneDetectedSubject
            .throttle(for: .milliseconds(100), scheduler: DispatchQueue.main, latest: true)
            .eraseToAnyPublisher()
    }

    public init(type: VirtualObjectType) {
        self.type = type

        super.init(nibName: nil, bundle: nil)

        configurePlaneDetection()
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
    }

    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        session.pause()
    }

    private func configurePlaneDetection() {
        guard let worldSessionConfig = sessionConfig as? ARWorldTrackingConfiguration else { return }

        worldSessionConfig.planeDetection = .horizontal
        session.run(worldSessionConfig, options: [.resetTracking, .removeExistingAnchors])
    }

    private func bindViews() {
        virtualObjectButton
            .throttledTap()
            .sink { [weak self] _ in
                self?.addVirtualObject()
            }
            .store(in: &disposables)

        horizontalPlaneDetected
            .sink { [weak self] isPlaneDetected in
                guard let self else { return }

                UIView.animate(withDuration: 0.2) {
                    self.virtualObjectButton.isEnabled = isPlaneDetected
                    self.virtualObjectButton.layer.opacity = isPlaneDetected ? 1 : 0.2
                    self.infoView.layer.opacity = isPlaneDetected ? 0 : 1
                }
            }
            .store(in: &disposables)
    }

}

extension VirtualObjectViewController: ARSCNViewDelegate {

    public func renderer(_ renderer: any SCNSceneRenderer, updateAtTime time: TimeInterval) {
        DispatchQueue.main.async {
            guard
                let center = self.screenCenter,
                let query = self.sceneView.raycastQuery(from: center, allowing: .estimatedPlane, alignment: .horizontal)
            else { return }

            self.horizontalPlaneDetectedSubject.send(!self.sceneView.session.raycast(query).isEmpty)
        }
    }

}

// MARK: - Adding and caching virtual object
extension VirtualObjectViewController {

    private func addVirtualObject() {
        guard
            let center = screenCenter,
            let query = self.sceneView.raycastQuery(from: center, allowing: .estimatedPlane, alignment: .horizontal),
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

        guard let url = Bundle.module.url(forResource: modelName, withExtension: type.fileExtension) else {
            print("Failed to find URL for model \(modelName) with extension \(type.fileExtension)")
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
