import Foundation

public protocol RoomScanRouterProtocol {

    func showRoomScanViewController()

    func presentSwitchModuleSheet()

    func switchModule()

    func presentShareSheet(for items: [URL])

}
