import UIKit
import Resolver
import Author
import CoreUi
import RoomScan
import VirtualObject

class AppRouter:
    NSObject,
    VirtualObjectRouterProtocol,
    RoomScanRouterProtocol,
    SwitchModuleRouterProtocol,
    AuthorRouterProtocol {

    private let navigationController = UINavigationController()
    private let container: Resolver

    private lazy var initialViewController: UIViewController = {
        let initialViewController: RoomScanLandingViewController = container.resolve(args: false)
        return initialViewController
    }()

    init(container: Resolver) {
        self.container = container

        super.init()

        configureNavigationBar()
    }

    private var currentViewController: UIViewController? {
        navigationController.viewControllers.last
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

    func showVirtualObjectViewController(for type: VirtualObjectType) {
        let virtualObjectViewController: VirtualObjectViewController = container.resolve(args: type)
        navigationController.pushViewController(virtualObjectViewController, animated: true)
    }

    func showRoomScanLandingViewController() {
        let roomScanLandingViewController: RoomScanLandingViewController = container.resolve(args: true)
        replaceLastViewController(with: roomScanLandingViewController)
    }

    func showRoomScanViewController() {
        let roomScanViewController: RoomScanViewController = container.resolve()
        navigationController.pushViewController(roomScanViewController, animated: true)
    }

    func presentSwitchModuleSheet() {
        let switchModuleViewController: SwitchModuleViewController = container.resolve()
        let modalViewController = ModalViewController(childViewController: switchModuleViewController)

        switchModuleViewController.onDismiss = {
            modalViewController.dismiss(animated: true)
        }

        navigationController.present(modalViewController, animated: true)
    }

    func authorViewTap() {
        let authorViewController: AuthorViewController = container.resolve()
        navigationController.pushViewController(authorViewController, animated: true)
    }

    func switchModule() {
        if navigationController.viewControllers.last is RoomScanLandingViewController {
            showVirtualObjectLandingViewController()
        } else if navigationController.viewControllers.last is VirtualObjectLandingViewController {
            showRoomScanLandingViewController()
        }
    }

    func presentShareSheet(for items: [URL]) {
        let activityViewController = UIActivityViewController(activityItems: items, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = currentViewController?.view
        currentViewController?.present(activityViewController, animated: true, completion: nil)
    }

    func showWebView(url: URL?) {
        guard let url else { return }

        UIApplication.shared.open(url)
    }

    private func configureNavigationBar() {
        navigationController.delegate = self
        UINavigationBar.appearance().backIndicatorImage = UIImage(with: .back)
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = UIImage(with: .back)
        UINavigationBar.appearance().backItem?.title = ""
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
