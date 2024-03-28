import Combine
import SceneKit
import UIKit
import SnapKit
import CoreUi

class RoomScanCardView: UIView {

    let defaultPadding: CGFloat = 8

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
        clipsToBounds = true

        layer.cornerRadius = 16
        layer.borderWidth = 2
        layer.borderColor = UIColor.black.cgColor

        stackView.spacing = defaultPadding * 2
        stackView.distribution = .fillProportionally
        stackView.alignment = .center

        previewImage.layer.cornerRadius = 4
        previewImage.layer.borderColor = UIColor.black.cgColor
        previewImage.layer.borderWidth = 1

        timeStackView.axis = .vertical
        timeStackView.spacing = 8

        dateLabel.textColor = .black
        dateLabel.font = UIFont(name: "Futura", size: 18)

        timeLabel.textColor = .darkGray
        timeLabel.font = UIFont(name: "Futura", size: 14)

        let image = UIImage(systemImage: .share)
        shareButton.setImage(image, for: .normal)
        shareButton.tintColor = .black
    }

    func defineLayoutForViews() {
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(defaultPadding * 2)
        }

        previewImage.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: 60, height: 60))
        }

        shareButton.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: 48, height: 48))
        }
    }

}
