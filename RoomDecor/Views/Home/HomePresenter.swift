import Foundation
import Combine

class HomePresenter {

    private let appRouter: AppRouter

    init(appRouter: AppRouter) {
        self.appRouter = appRouter
    }

    func presentAddVirtualObjectViewController() {
        appRouter.presentAddVirtualObjectViewController(from: .home)
    }

    func presentScanRoomViewController() {
        appRouter.presentScanRoomViewController(from: .home)
    }

}
