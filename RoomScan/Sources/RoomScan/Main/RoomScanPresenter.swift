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
        appRouter.presentShareSheet(for: items)
    }

}

extension RoomScanPresenter {

    var exportUrl: URL {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let dateString = Date.format(Date(), using: .fullDateTime)
        let fileName = "scan_"
            .appending(dateString)
            .appending(FileType.usdz.fileExtension)

        let url = documentsDirectory.appendingPathComponent(fileName)
        print("logger \(url)")
        return documentsDirectory.appendingPathComponent(fileName)
    }

}
