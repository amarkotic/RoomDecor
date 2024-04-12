import UIKit
import SnapKit
import CoreUi

extension HeaderView {

    func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }

    func createViews() {
        stackView = UIStackView()
        addSubview(stackView)

        textStackView = UIStackView()
        stackView.addArrangedSubview(textStackView)

        nameLabel = UILabel()
        textStackView.addArrangedSubview(nameLabel)

        roleLabel = UILabel()
        textStackView.addArrangedSubview(roleLabel)

        imageView = UIImageView()
        stackView.addArrangedSubview(imageView)
    }

    func styleViews() {
        stackView.axis = .vertical
        stackView.spacing = defaultPadding * 2
        stackView.alignment = .leading

        textStackView.axis = .vertical
        textStackView.spacing = defaultPadding / 2
        textStackView.alignment = .leading

        nameLabel.text = LocalizableStrings.name.localized
        nameLabel.textColor = .black
        nameLabel.font = UIFont(with: .futura, size: 18)

        roleLabel.text = LocalizableStrings.iosEngineer.localized
        roleLabel.textColor = .black
        roleLabel.font = UIFont(with: .futura, size: 16)

        imageView.image = UIImage(named: BundleImage.author.rawValue, in: Bundle.module, with: nil)
        imageView.contentMode = .scaleAspectFill
        imageView.roundAllCorners(withRadius: 8)
        imageView.addBorder()
    }

    func defineLayoutForViews() {
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(defaultPadding * 2)
        }

        imageView.snp.makeConstraints {
            $0.height.equalTo(200)
        }
    }

}
