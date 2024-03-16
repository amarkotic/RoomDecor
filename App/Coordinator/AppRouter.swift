import UIKit
import Resolver
import CoreUi
import RoomScan
import VirtualObject

class AppRouter: NSObject, VirtualObjectRouterProtocol, RoomScanRouterProtocol, SwitchModuleRouterProtocol {

    private let navigationController = UINavigationController()
    private let container: Resolver

    private lazy var initialViewController: UIViewController = {
        let initialViewController: RoomScanLandingViewController = container.resolve()
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

    func showVirtualObjectLandingViewController() {
        let virtualObjectLandingViewController: VirtualObjectLandingViewController = container.resolve()
        replaceLastViewController(with: virtualObjectLandingViewController)
    }

    func showVirtualObjectViewController() {
        let virtualObjectViewController: VirtualObjectViewController = container.resolve()
        navigationController.pushViewController(virtualObjectViewController, animated: true)
    }

    func showRoomScanLandingViewController() {
        let roomScanLandingViewController: RoomScanLandingViewController = container.resolve()
        replaceLastViewController(with: roomScanLandingViewController)
    }

    func showRoomScanViewController() {
        let roomScanViewController: RoomScanViewController = container.resolve()
        navigationController.pushViewController(roomScanViewController, animated: true)
    }

    func presentSwitchModuleSheet() {
        let switchModuleViewController: SwitchModuleViewController = container.resolve()
        let modalViewController = ModalViewController(childViewController: switchModuleViewController)
        navigationController.present(modalViewController, animated: true)
    }

    func authorViewTap() {
        // Todo
    }

    func switchModule() {
        if navigationController.viewControllers.last is RoomScanLandingViewController {
            showVirtualObjectLandingViewController()
        } else if navigationController.viewControllers.last is VirtualObjectLandingViewController {
            showRoomScanLandingViewController()
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
            fromVC is VirtualObjectLandingViewController && toVC is RoomScanLandingViewController ||
            fromVC is RoomScanLandingViewController && toVC is VirtualObjectLandingViewController
        else { return nil }

        return TransitionManager(duration: 1.5)
    }

}
