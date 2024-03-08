import Foundation
import Combine

class AddVirtualObjectPresenter {

    private let appRouter: AppRouter

    init(appRouter: AppRouter) {
        self.appRouter = appRouter
    }

    func switchButtonTapped() {
        appRouter.presentScanRoomViewController(from: .other)
    }

}
