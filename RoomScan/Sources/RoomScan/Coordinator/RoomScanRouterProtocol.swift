import Foundation
import CoreUi

public protocol RoomScanRouterProtocol {

    func showRoomScanViewController()

    func presentSwitchModuleSheet()

    func switchModule()

    func presentShareSheet(for items: [URL])

    func showErrorPopup(for type: RoomScanErrorType)

}
