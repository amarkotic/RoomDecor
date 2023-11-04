import UIKit
import Resolver

class AppRouter {

    private let navigationController = UINavigationController()
    private let container: Resolver

    init(container: Resolver) {
        self.container = container
    }

    func setStartScreen(in window: UIWindow?) {
        navigationController.setViewControllers([ViewController()], animated: false)

        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }

}
