public enum FileType {

    case scn
    case usdz

    public var fileExtension: String {
        switch self {
        case .scn:
            ".scn"
        case .usdz:
            ".usdz"
        }
    }

}

extension FileType {

    init?(from fileExtension: String) {
        if fileExtension == "scn" {
            self = .scn
        } else if fileExtension == "usdz" {
            self = .usdz
        } else {
            return nil
        }
    }

}
