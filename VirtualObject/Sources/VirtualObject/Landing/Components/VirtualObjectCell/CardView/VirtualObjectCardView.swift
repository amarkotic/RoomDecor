import UIKit
import SceneKit
import Core

class VirtualObjectCardView: UIView {

    let defaultPadding: CGFloat = 16
    let cornerRadius: CGFloat = 16

    var stackView: UIStackView!
    var imageView: UIImageView!
    var titleLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)

        buildViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(type: VirtualObjectType) {
        titleLabel.text = type.title

        guard
            let url = Bundle.module.url(forResource: type.rawValue, withExtension: FileType.usdz.fileExtension)
        else { return }

        imageView.load3DModelThumbnail(from: url)
    }

}
