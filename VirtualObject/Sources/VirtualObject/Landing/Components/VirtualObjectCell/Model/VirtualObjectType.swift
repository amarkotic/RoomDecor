import Foundation
import Core

public enum VirtualObjectType: String, CaseIterable {

    case armchair
    case chair
    case smallShelf
    case lamp
    case sideTable
    case shelf
    case stool
    case table

    var title: String {
        switch self {
        case .armchair:
            LocalizableStrings.armchair.localized
        case .chair:
            LocalizableStrings.chair.localized
        case .smallShelf:
            LocalizableStrings.smallShelf.localized
        case .lamp:
            LocalizableStrings.lamp.localized
        case .sideTable:
            LocalizableStrings.sideTable.localized
        case .shelf:
            LocalizableStrings.shelf.localized
        case .stool:
            LocalizableStrings.stool.localized
        case .table:
            LocalizableStrings.table.localized
        }
    }

    var usdzFileName: String {
        rawValue + FileType.usdz.fileExtension
    }

}
