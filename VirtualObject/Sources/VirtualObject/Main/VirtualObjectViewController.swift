import ARKit
import Combine
import UIKit
import Core
import CoreUi

public class VirtualObjectViewController: UIViewController {

    let session = ARSession()
    let defaultPadding: CGFloat = 8
    let cornerRadius: CGFloat = 4
    let buttonHeight: CGFloat = 50
    let sightImageSize = CGSize(width: 100, height: 100)

    var sceneView: ARSCNView!
    var sightImageView: UIImageView!
    var infoView: InfoView!
    var virtualObjectButton: UIButton!

    private let presenter: VirtualObjectPresenter!

    private var screenCenter: CGPoint?
    private var disposables = Set<AnyCancellable>()
    private var sessionConfig: ARConfiguration = ARWorldTrackingConfiguration()

    private var horizontalPlaneDetectedSubject = PassthroughSubject<Bool, Never>()

    var horizontalPlaneDetected: AnyPublisher<Bool, Never> {
        horizontalPlaneDetectedSubject
            .throttle(for: .milliseconds(100), scheduler: DispatchQueue.main, latest: true)
            .eraseToAnyPublisher()
    }

    public init(presenter: VirtualObjectPresenter) {
        self.presenter = presenter

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
        guard let worldSessionConfig = sessionConfig as? ARWorldTrackingConfiguration else {
            presenter.showErrorPopup(for: .session)
            return
        }

        worldSessionConfig.planeDetection = .horizontal
        session.run(worldSessionConfig, options: [.resetTracking, .removeExistingAnchors])
    }

    private func bindViews() {
        virtualObjectButton
            .throttledTap()
            .sink { [weak self] _ in
                guard let self else { return }

                self.presenter.addVirtualObject(screenCenter: self.screenCenter, sceneView: self.sceneView)
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
