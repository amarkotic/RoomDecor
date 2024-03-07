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
    }

    private func registerAppRouter(in container: Resolver) {
        container
            .register { AppRouter(container: container) }
            .scope(.application)
    }

    private func registerHomeViewController(in container: Resolver) {
        container
            .register { HomeViewController() }
            .scope(.unique)
    }

}
