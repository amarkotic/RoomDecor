import Combine
import Foundation
import Core

public class RoomScanPresenter {

    @Published var canExport: Bool = false

    private let appRouter: RoomScanRouterProtocol

    public init(appRouter: RoomScanRouterProtocol) {
        self.appRouter = appRouter
    }

    func presentShareSheet(for items: [URL]) {
        appRouter.presentShareSheet(for: [exportUrl])
    }

}

extension RoomScanPresenter {

    var exportUrl: URL {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileName = "scan_\(Date()).usdz"
        return documentsDirectory.appendingPathComponent(fileName)
    }

}