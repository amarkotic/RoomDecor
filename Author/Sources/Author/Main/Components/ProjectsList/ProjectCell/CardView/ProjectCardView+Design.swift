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
        stackView = UIStackView()
        addSubview(stackView)

        imageView = UIImageView()
        addSubview(imageView)

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
        stackView.alignment = .center

        titleLabel.textColor = .darkGray
        titleLabel.font = UIFont(with: .futura, size: 16)

        descriptionLabel.textColor = .darkGray
        descriptionLabel.font = UIFont(with: .futura, size: 16)
    }

    func defineLayoutForViews() {
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        stackView.snp.makeConstraints {
            $0.leading.bottom.equalToSuperview().offset(defaultPadding)
        }
    }

}
