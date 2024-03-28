public enum FileType {

    case scn
    case usdz

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
