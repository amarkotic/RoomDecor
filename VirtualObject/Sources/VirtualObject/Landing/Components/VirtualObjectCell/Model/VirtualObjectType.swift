import Foundation

public enum VirtualObjectType: String, CaseIterable {

    case armchair
    case chair
    case carpet
    case pouf
    case sideTable
    case sofa
    case table

    var title: String {
        switch self {
        case .armchair:
            LocalizableStrings.armchair.localized
        case .chair:
            LocalizableStrings.chair.localized
        case .carpet:
            LocalizableStrings.carpet.localized
        case .pouf:
            LocalizableStrings.pouf.localized
        case .sideTable:
            LocalizableStrings.sideTable.localized
        case .sofa:
            LocalizableStrings.sofa.localized
        case .table:
            LocalizableStrings.table.localized
        }
    }

    var usdzFileName: String {
        rawValue + ".usdz"
    }

}
