import UIKit
import Resolver

class AppRouter: NSObject {

    private let navigationController = UINavigationController()
    private let container: Resolver

    private lazy var homeViewController: UIViewController = {
        let homeViewController: HomeViewController = container.resolve()
        return homeViewController
    }()

    init(container: Resolver) {
        self.container = container

        super.init()

        navigationController.delegate = self
    }

    func setStartScreen(in window: UIWindow?) {
        navigationController.setViewControllers([homeViewController], animated: false)

        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }

    func showAddVirtualObjectViewController(from source: SourceViewController) {
        let addVirtualObjectViewController: AddVirtualObjectViewController = container.resolve()

        switch source {
        case .home:
            navigationController.pushViewController(addVirtualObjectViewController, animated: true)
        case .scanRoom:
            replaceLastViewController(with: addVirtualObjectViewController)
        default:
            return
        }
    }

    func showScanRoomViewController(from source: SourceViewController) {
        let scanRoomViewController: ScanRoomViewController = container.resolve()

        switch source {
        case .home:
            navigationController.pushViewController(scanRoomViewController, animated: true)
        case .addVirtualObject:
            replaceLastViewController(with: scanRoomViewController)
        default:
            return
        }
    }

    func presentSwitchModuleSheet() {
        let switchModuleViewController: SwitchModuleViewController = container.resolve()
        let modalViewController = ModalViewController(childViewController: switchModuleViewController)
        navigationController.present(modalViewController, animated: true)
    }

}

// MARK: - Helpers functions
extension AppRouter {

    func replaceLastViewController(with viewController: UIViewController, animated: Bool = true) {
        var viewControllers = navigationController.viewControllers

        guard !viewControllers.isEmpty else {
            navigationController.setViewControllers([viewController], animated: animated)
            return
        }

        viewControllers[viewControllers.count - 1] = viewController
        navigationController.setViewControllers(viewControllers, animated: animated)
    }

}

// MARK: - Custom navigation transition
extension AppRouter: UINavigationControllerDelegate {

    func navigationController(
        _ navigationController: UINavigationController,
        animationControllerFor operation: UINavigationController.Operation,
        from fromVC: UIViewController,
        to toVC: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        guard
            fromVC is AddVirtualObjectViewController && toVC is ScanRoomViewController ||
            fromVC is ScanRoomViewController && toVC is AddVirtualObjectViewController
        else { return nil }

        return TransitionManager(duration: 1.5)
    }

}
