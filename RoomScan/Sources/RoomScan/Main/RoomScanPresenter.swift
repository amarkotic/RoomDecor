import Combine
import Foundation
import Core

public class RoomScanPresenter {

    @Published var isReadyToSave: Bool = false

    private let appRouter: RoomScanRouterProtocol

    public init(appRouter: RoomScanRouterProtocol) {
        self.appRouter = appRouter
    }

    func presentShareSheet() {
        appRouter.presentShareSheet(for: [exportUrl])
    }

    func showErrorPopup(for type: RoomScanErrorType) {
        appRouter.showErrorPopup(for: type)
    }

}

extension RoomScanPresenter {

    var exportUrl: URL {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let dateString = Date.format(Date(), using: .fullDateTime)
        let fileName = "scan_"
            .appending(dateString)
            .appending(FileType.usdz.fileExtension)
        return documentsDirectory.appendingPathComponent(fileName)
    }

}
