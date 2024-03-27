import Foundation
import Combine
import Core
import CoreUi

public class RoomScanLandingPresenter {

    var roomScanModels: [RoomScanViewModel] = []

    private let appRouter: RoomScanRouterProtocol

    public init(appRouter: RoomScanRouterProtocol) {
        self.appRouter = appRouter
        self.roomScanModels = savedFilesUrls
            .map { RoomScanViewModel(url: $0) }
            .sorted { ($0.extractedDateTime ?? Date.distantPast) > ($1.extractedDateTime ?? Date.distantPast) }
    }

    func switchButtonInteracted(with interaction: SwitchModuleInteractionType) {
        switch interaction {
        case .tap:
            appRouter.presentSwitchModuleSheet()
        case .longPress:
            appRouter.switchModule()
        }
    }

    func startRoomScanTapped() {
        appRouter.showRoomScanViewController()
    }

    func presentShareSheet(for items: [URL]) {
        appRouter.presentShareSheet(for: items)
    }

}

extension RoomScanLandingPresenter {

    var savedFilesUrls: [URL] {
        guard
            let documentsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        else { return [] }

        do {
            let urls = try FileManager.default.contentsOfDirectory(at: documentsUrl, includingPropertiesForKeys: nil)
                .filter { $0.fileType == .usdz }

            return urls
        } catch {
            print(error)
            return []
        }
    }

}
