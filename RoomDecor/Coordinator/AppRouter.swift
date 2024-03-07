import UIKit
import Resolver

class AppRouter {

    private let navigationController = UINavigationController()
    private let container: Resolver

    private lazy var homeViewController: UIViewController = {
        let homeViewController: HomeViewController = container.resolve()
        return homeViewController
    }()

    init(container: Resolver) {
        self.container = container
    }

    func setStartScreen(in window: UIWindow?) {
        navigationController.setViewControllers([homeViewController], animated: false)

        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }

    func presentAddVirtualObjectViewController() {
        let addVirtualObjectViewController: AddVirtualObjectViewController = container.resolve()
        navigationController.pushViewController(addVirtualObjectViewController, animated: true)
    }

    func presentScanRoomViewController() {
        let scanRoomViewController: ScanRoomViewController = container.resolve()
        navigationController.pushViewController(scanRoomViewController, animated: true)
    }

}
