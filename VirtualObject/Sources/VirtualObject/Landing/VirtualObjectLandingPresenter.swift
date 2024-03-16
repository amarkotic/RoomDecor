import Foundation
import Combine
import CoreUi

public class VirtualObjectLandingPresenter {

    private let appRouter: VirtualObjectRouterProtocol

    public init(appRouter: VirtualObjectRouterProtocol) {
        self.appRouter = appRouter
    }

    func switchButtonInteracted(with interaction: SwitchModuleInteractionType) {
        switch interaction {
        case .tap:
            appRouter.presentSwitchModuleSheet()
        case .longPress:
            appRouter.switchModule()
        }
    }

    func startVirtualObject(for type: VirtualObjectType) {
        appRouter.showVirtualObjectViewController(for: type)
    }

}
