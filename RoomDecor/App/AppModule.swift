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
        registerHomeViewController(in: container)
        registerAddVirtualObjectViewController(in: container)
        registerScanRoomViewController(in: container)
    }

    private func registerAppRouter(in container: Resolver) {
        container
            .register { AppRouter(container: container) }
            .scope(.application)
    }

    private func registerHomeViewController(in container: Resolver) {
        container
            .register { HomeViewController(presenter: container.resolve()) }
            .scope(.unique)

        container
            .register { HomePresenter(appRouter: container.resolve()) }
            .scope(.unique)
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

}
