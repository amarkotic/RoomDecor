import UIKit
import Resolver

class AppRouter: NSObject {

    private let navigationController = UINavigationController()
    private let container: Resolver

    private lazy var initialViewController: UIViewController = {
        let initialViewController: ScanRoomLandingViewController = container.resolve()
        return initialViewController
    }()

    init(container: Resolver) {
        self.container = container

        super.init()

        navigationController.delegate = self
    }

    func setStartScreen(in window: UIWindow?) {
        navigationController.setViewControllers([initialViewController], animated: false)

        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }

    func showAddVirtualObjectLandingViewController() {
        let addVirtualObjectLandingViewController: AddVirtualObjectLandingViewController = container.resolve()
        replaceLastViewController(with: addVirtualObjectLandingViewController)
    }

    func showAddVirtualObjectViewController() {
        let addVirtualObjectViewController: AddVirtualObjectViewController = container.resolve()
        navigationController.pushViewController(addVirtualObjectViewController, animated: true)
    }

    func showScanRoomLandingViewController() {
        let scanRoomLandingViewController: ScanRoomLandingViewController = container.resolve()
        replaceLastViewController(with: scanRoomLandingViewController)
    }

    func showScanRoomViewController() {
        let scanRoomViewController: ScanRoomViewController = container.resolve()
        navigationController.pushViewController(scanRoomViewController, animated: true)
    }

    func presentSwitchModuleSheet() {
        let switchModuleViewController: SwitchModuleViewController = container.resolve()
        let modalViewController = ModalViewController(childViewController: switchModuleViewController)
        navigationController.present(modalViewController, animated: true)
    }

    func switchModule() {
        if navigationController.viewControllers.last is ScanRoomLandingViewController {
            showAddVirtualObjectLandingViewController()
        } else if navigationController.viewControllers.last is AddVirtualObjectLandingViewController {
            showScanRoomLandingViewController()
        }
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
            fromVC is AddVirtualObjectLandingViewController && toVC is ScanRoomLandingViewController ||
            fromVC is ScanRoomLandingViewController && toVC is AddVirtualObjectLandingViewController
        else { return nil }

        return TransitionManager(duration: 1.5)
    }

}
