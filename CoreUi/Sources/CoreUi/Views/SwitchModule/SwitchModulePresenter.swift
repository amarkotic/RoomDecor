import Foundation
import Combine

public class SwitchModulePresenter: SwitchModuleRouterProtocol {

    private let appRouter: SwitchModuleRouterProtocol

    public init(appRouter: SwitchModuleRouterProtocol) {
        self.appRouter = appRouter
    }

    public func authorViewTap() {
        // TODO: - Implement author screen
    }

    public func switchModule() {
        appRouter.switchModule()
    }

}
