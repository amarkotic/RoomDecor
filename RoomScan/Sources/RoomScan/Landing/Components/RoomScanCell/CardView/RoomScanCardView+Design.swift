import UIKit
import SnapKit
import CoreUi

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
        backgroundColor = .beige

        roundAllCorners(withRadius: cornerRadius)
        addBorder(width: 2, color: .black)

        stackView.spacing = defaultPadding * 2
        stackView.distribution = .fillProportionally
        stackView.alignment = .center

        previewImage.roundAllCorners(withRadius: 4)
        previewImage.addBorder(width: 1, color: .black)
        previewImage.backgroundColor = .white

        timeStackView.axis = .vertical
        timeStackView.spacing = 8

        dateLabel.textColor = .black
        dateLabel.font = UIFont(with: .futura, size: 18)

        timeLabel.textColor = .darkGray
        timeLabel.font = UIFont(with: .futura, size: 14)

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
