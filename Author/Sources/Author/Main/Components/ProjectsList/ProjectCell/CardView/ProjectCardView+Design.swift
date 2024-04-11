import UIKit
import SnapKit
import CoreUi

extension ProjectCardView {

    func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }

    func createViews() {
        imageView = UIImageView()
        addSubview(imageView)

        stackView = UIStackView()
        addSubview(stackView)

        titleLabel = UILabel()
        stackView.addArrangedSubview(titleLabel)

        descriptionLabel = UILabel()
        stackView.addArrangedSubview(descriptionLabel)
    }

    func styleViews() {
        backgroundColor = .white
        roundAllCorners(withRadius: cornerRadius)
        addBorder(width: 2, color: .black)

        imageView.contentMode = .scaleAspectFill

        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.backgroundColor = .gray.withAlphaComponent(0.1)
        stackView.roundAllCorners(withRadius: 8)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = .insets(vertical: 4, horizontal: 4)

        titleLabel.textColor = .black
        titleLabel.font = UIFont(with: .futura, size: 12)

        descriptionLabel.textColor = .black
        descriptionLabel.font = UIFont(with: .futura, size: 12)
    }

    func defineLayoutForViews() {
        imageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(imageSize)
        }

        stackView.snp.makeConstraints {
            $0.leading.bottom.equalToSuperview().inset(defaultPadding)
        }
    }

}
