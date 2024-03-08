import Foundation
import Combine

class ScanRoomPresenter {

    private let appRouter: AppRouter

    init(appRouter: AppRouter) {
        self.appRouter = appRouter
    }

    func switchButtonTapped() {
        appRouter.presentAddVirtualObjectViewController(from: .other)
    }

}
