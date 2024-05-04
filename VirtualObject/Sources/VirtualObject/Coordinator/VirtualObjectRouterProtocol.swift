public protocol VirtualObjectRouterProtocol {

    func showVirtualObjectViewController(for type: VirtualObjectType)

    func presentSwitchModuleSheet()

    func switchModule()

    func showErrorPopup(for type: VirtualObjectErrorType)

}
