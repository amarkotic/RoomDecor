import Foundation

public extension URL {

    var fileType: FileType? {
        FileType(from: self.pathExtension)
    }

}
