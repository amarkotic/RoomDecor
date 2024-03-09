import UIKit
import Resolver

class AppModule {

    private let container: Resolver

    init() {
        self.container = Resolver.main
        registerAllServices(in: container)
    }

    func startRouter(with window: UIWindow) {
        let appRouter: AppRouter = container.resolve()
        appRouter.setStartScreen(in: window)
    }

    func registerAllServices(in container: Resolver) {
        registerAppRouter(in: container)
        registerAddVirtualObjectViewController(in: container)
        registerScanRoomViewController(in: container)
        registerSwitchModuleViewController(in: container)
        registerScanRoomLandingViewController(in: container)
        registerAddVirtualObjectLandingViewController(in: container)
    }

    private func registerAppRouter(in container: Resolver) {
        container
            .register { AppRouter(container: container) }
            .scope(.application)
    }

    private func registerAddVirtualObjectViewController(in container: Resolver) {
        container
            .register { AddVirtualObjectViewController() }
            .scope(.unique)
    }

    private func registerScanRoomViewController(in container: Resolver) {
        container
            .register { ScanRoomViewController(viewModel: container.resolve()) }
            .scope(.unique)

        container
            .register { ScanRoomViewModel() }
            .scope(.unique)
    }

    private func registerSwitchModuleViewController(in container: Resolver) {
        container
            .register { SwitchModuleViewController(presenter: container.resolve()) }
            .scope(.unique)

        container
            .register { SwitchModulePresenter(appRouter: container.resolve()) }
            .scope(.unique)
    }

    private func registerScanRoomLandingViewController(in container: Resolver) {
        container
            .register { ScanRoomLandingViewController(presenter: container.resolve()) }
            .scope(.unique)

        container
            .register { ScanRoomLandingPresenter(appRouter: container.resolve()) }
            .scope(.unique)
    }

    private func registerAddVirtualObjectLandingViewController(in container: Resolver) {
        container
            .register { AddVirtualObjectLandingViewController(presenter: container.resolve()) }
            .scope(.unique)

        container
            .register { AddVirtualObjectLandingPresenter(appRouter: container.resolve()) }
            .scope(.unique)
    }

}
