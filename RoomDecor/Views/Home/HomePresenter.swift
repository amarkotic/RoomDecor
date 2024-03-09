import Foundation
import Combine

class HomePresenter {

    private let appRouter: AppRouter

    init(appRouter: AppRouter) {
        self.appRouter = appRouter
    }

    func presentAddVirtualObjectViewController() {
        appRouter.showAddVirtualObjectViewController(from: .home)
    }

    func presentScanRoomViewController() {
        appRouter.showScanRoomViewController(from: .home)
    }

}
