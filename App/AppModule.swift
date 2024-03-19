import UIKit
import Resolver
import CoreUi
import RoomScan
import VirtualObject

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
        registerVirtualObjectViewController(in: container)
        registerRoomScanViewController(in: container)
        registerSwitchModuleViewController(in: container)
        registerRoomScanLandingViewController(in: container)
        registerVirtualObjectLandingViewController(in: container)
    }

    private func registerAppRouter(in container: Resolver) {
        container
            .register { AppRouter(container: container) }
            .implements(VirtualObjectRouterProtocol.self)
            .implements(RoomScanRouterProtocol.self)
            .implements(SwitchModuleRouterProtocol.self)
            .scope(.application)
    }

    private func registerVirtualObjectViewController(in container: Resolver) {
        container.register { (_, args) -> VirtualObjectViewController in
            let type: VirtualObjectType = args()
            return VirtualObjectViewController(type: type)
        }
        .scope(.unique)
    }

    private func registerRoomScanViewController(in container: Resolver) {
        container
            .register { RoomScanViewController(presenter: container.resolve()) }
            .scope(.unique)

        container
            .register { RoomScanPresenter(appRouter: container.resolve()) }
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

    private func registerRoomScanLandingViewController(in container: Resolver) {
        container
            .register { RoomScanLandingViewController(presenter: container.resolve()) }
            .scope(.unique)

        container
            .register { RoomScanLandingPresenter(appRouter: container.resolve()) }
            .scope(.unique)
    }

    private func registerVirtualObjectLandingViewController(in container: Resolver) {
        container
            .register { VirtualObjectLandingViewController(presenter: container.resolve()) }
            .scope(.unique)

        container
            .register { VirtualObjectLandingPresenter(appRouter: container.resolve()) }
            .scope(.unique)
    }

}
