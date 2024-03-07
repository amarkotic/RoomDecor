import ARKit

extension ARSCNView {

    func setUp(_ session: ARSession) {
        self.session = session
        antialiasingMode = .multisampling4X
        automaticallyUpdatesLighting = false
        preferredFramesPerSecond = 60
        contentScaleFactor = 1.3
        enableEnvironmentMapWithIntensity(25.0)
        if let camera = pointOfView?.camera {
            camera.wantsHDR = true
            camera.wantsExposureAdaptation = true
            camera.exposureOffset = -1
            camera.minimumExposure = -1
        }
    }

    func enableEnvironmentMapWithIntensity(_ intensity: CGFloat) {
        scene.lightingEnvironment.intensity = intensity

        guard
            scene.lightingEnvironment.contents == nil,
            let environmentMap = UIImage(named: "Models.scnassets/sharedImages/environment_blur.exr")
        else { return }

        scene.lightingEnvironment.contents = environmentMap
    }

}
