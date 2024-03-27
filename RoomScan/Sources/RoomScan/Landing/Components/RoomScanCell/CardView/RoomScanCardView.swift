import Combine
import SceneKit
import UIKit
import SnapKit
import CoreUi

class RoomScanCardView: UIView {

    let defaultPadding: CGFloat = 8

    var previewImage: UIImageView!
    var stackView: UIStackView!
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
        previewImage = UIImageView()
        addSubview(previewImage)

        stackView = UIStackView()
        addSubview(stackView)

        dateLabel = UILabel()
        stackView.addArrangedSubview(dateLabel)

        timeLabel = UILabel()
        stackView.addArrangedSubview(timeLabel)

        shareButton = UIButton()
        addSubview(shareButton)
    }

    func styleViews() {
        backgroundColor = .white
        clipsToBounds = true

        layer.cornerRadius = 16
        layer.borderWidth = 2
        layer.borderColor = UIColor.black.cgColor

        previewImage.layer.cornerRadius = 4
        previewImage.layer.borderColor = UIColor.black.cgColor
        previewImage.layer.borderWidth = 1

        stackView.axis = .vertical
        stackView.spacing = 8

        dateLabel.textColor = .black
        dateLabel.font = UIFont(name: "Futura", size: 18)

        timeLabel.textColor = .darkGray
        timeLabel.font = UIFont(name: "Futura", size: 14)

        let image = UIImage(systemImage: .share)
        shareButton.setImage(image, for: .normal)
        shareButton.tintColor = .black
    }

    func defineLayoutForViews() {
        previewImage.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(defaultPadding * 3)
            $0.size.equalTo(CGSize(width: 60, height: 60))
        }

        stackView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(previewImage.snp.trailing).offset(defaultPadding * 2)
        }

        shareButton.snp.makeConstraints {
            $0.leading.greaterThanOrEqualTo(stackView.snp.trailing).offset(defaultPadding * 2)
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(defaultPadding * 3)
            $0.size.equalTo(CGSize(width: 48, height: 48))
        }
    }

}
