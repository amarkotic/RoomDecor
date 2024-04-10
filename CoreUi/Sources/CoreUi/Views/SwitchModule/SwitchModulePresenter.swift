import Foundation
import Combine

public class SwitchModulePresenter: SwitchModuleRouterProtocol {

    private let appRouter: SwitchModuleRouterProtocol

    public init(appRouter: SwitchModuleRouterProtocol) {
        self.appRouter = appRouter
    }

    public func authorViewTap() {
        appRouter.authorViewTap()
    }

    public func switchModule() {
        appRouter.switchModule()
    }

}
