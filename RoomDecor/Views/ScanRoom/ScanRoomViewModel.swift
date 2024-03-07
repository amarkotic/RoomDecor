import Combine
import Foundation

class ScanRoomViewModel: ObservableObject {

    enum Action {

        case startSession
        case placeBlock
        case removeAllBlocks
        case export

    }

    var actions = PassthroughSubject<Action, Never>()

    let exportUrl = FileManager.default.temporaryDirectory.appending(path: "scan.usdz")
    @Published var canExport = false
    @Published var showShareSheet = false
    @Published var canPlaceBlock = false
    @Published var canDeleteBlocks = false

}
