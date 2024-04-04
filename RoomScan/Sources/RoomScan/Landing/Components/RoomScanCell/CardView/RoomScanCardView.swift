import Combine
import SceneKit

class RoomScanCardView: UIView {

    let defaultPadding: CGFloat = 8
    let cornerRadius: CGFloat = .doublePadding
    let previewImageSize = CGSize(width: 60, height: 60)
    let shareButtonSize = CGSize(width: 48, height: 48)

    var stackView: UIStackView!
    var previewImage: UIImageView!
    var timeStackView: UIStackView!
    var dateLabel: UILabel!
    var timeLabel: UILabel!
    var shareButton: UIButton!

    override init(frame: CGRect) {
        super.init(frame: frame)

        buildViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(model: RoomScanViewModel) {
        dateLabel.text = model.dateString
        timeLabel.text = model.timeString
        previewImage.load3DModelThumbnail(from: model.url)
    }

}
