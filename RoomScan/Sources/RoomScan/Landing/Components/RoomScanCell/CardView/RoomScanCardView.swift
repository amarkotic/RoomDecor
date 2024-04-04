import Combine
import SceneKit
import UIKit
import SnapKit
import CoreUi

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

extension RoomScanCardView {

    func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }

    func createViews() {
        stackView = UIStackView()
        addSubview(stackView)

        previewImage = UIImageView()
        stackView.addArrangedSubview(previewImage)

        timeStackView = UIStackView()
        stackView.addArrangedSubview(timeStackView)

        dateLabel = UILabel()
        timeStackView.addArrangedSubview(dateLabel)

        timeLabel = UILabel()
        timeStackView.addArrangedSubview(timeLabel)

        shareButton = UIButton()
        stackView.addArrangedSubview(shareButton)
    }

    func styleViews() {
        backgroundColor = .white

        roundAllCorners(withRadius: cornerRadius)
        addBorder(width: 2, color: .black)

        stackView.spacing = defaultPadding * 2
        stackView.distribution = .fillProportionally
        stackView.alignment = .center

        previewImage.roundAllCorners(withRadius: 4)
        previewImage.addBorder(width: 1, color: .black)

        timeStackView.axis = .vertical
        timeStackView.spacing = 8

        dateLabel.textColor = .black
        titleLabel.font = UIFont(with: .futura, size: 18)

        timeLabel.textColor = .darkGray
        titleLabel.font = UIFont(with: .futura, size: 14)

        let image = UIImage(systemImage: .share)
        shareButton.setImage(image, for: .normal)
        shareButton.tintColor = .black
    }

    func defineLayoutForViews() {
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(defaultPadding * 2)
        }

        previewImage.snp.makeConstraints {
            $0.size.equalTo(previewImageSize)
        }

        shareButton.snp.makeConstraints {
            $0.size.equalTo(shareButtonSize)
        }
    }

}
