import UIKit
import Author

class Approuter: AuthorRouterProtocol {

    func showWebView(url: URL?) {
        guard let url else { return }

        UIApplication.shared.open(url)
    }

}
