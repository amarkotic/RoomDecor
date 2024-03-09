import Foundation
import Combine

class ScanRoomPresenter {

    private let appRouter: AppRouter

    init(appRouter: AppRouter) {
        self.appRouter = appRouter
    }

    func switchButtonInteracted(with interaction: SwitchModuleInteractionType) {
        switch interaction {
        case .tap:
            appRouter.presentSwitchModuleSheet()
        case .longPress:
            appRouter.showAddVirtualObjectViewController(from: .scanRoom)
        }
    }

}
