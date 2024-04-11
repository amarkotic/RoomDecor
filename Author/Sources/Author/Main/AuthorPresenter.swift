import Combine
import Foundation
import Core

public class AuthorPresenter {

    private let appRouter: AuthorRouterProtocol

    public init(appRouter: AuthorRouterProtocol) {
        self.appRouter = appRouter
    }

    func showWebView(url: URL?) {
        appRouter.showWebView(url: url)
    }

}
