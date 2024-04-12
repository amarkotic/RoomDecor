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

        titleLabel = UILabel()
        stackView.addArrangedSubview(titleLabel)

        textStackView = UIStackView()
        stackView.addArrangedSubview(textStackView)

        nameLabel = UILabel()
        textStackView.addArrangedSubview(nameLabel)

        roleLabel = UILabel()
        textStackView.addArrangedSubview(roleLabel)

        imageView = UIImageView()
        stackView.addArrangedSubview(imageView)

        imageStackView = UIStackView()
        addSubview(imageStackView)

        leadingButton = UIButton()
        imageStackView.addArrangedSubview(leadingButton)

        trailingButton = UIButton()
        imageStackView.addArrangedSubview(trailingButton)
    }

    func styleViews() {
        stackView.axis = .vertical
        stackView.spacing = defaultPadding * 2
        stackView.alignment = .leading

        titleLabel.text = LocalizableStrings.meetTheAuthor.localized
        titleLabel.textColor = .black
        titleLabel.font = UIFont(with: .futura, size: 24)

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

        imageStackView.distribution = .fill
        imageStackView.spacing = defaultPadding * 2
        imageStackView.alignment = .center

        leadingButton.setImage(UIImage(named: BundleImage.github.rawValue, in: Bundle.module, with: nil), for: .normal)
        leadingButton.imageView?.contentMode = .scaleAspectFill

        trailingButton.setImage(UIImage(named: BundleImage.linkedin.rawValue, in: Bundle.module, with: nil), for: .normal)
        trailingButton.imageView?.contentMode = .scaleAspectFill
    }

    func defineLayoutForViews() {
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(defaultPadding * 2)
        }

        imageView.snp.makeConstraints {
            $0.height.equalTo(200)
        }

        imageStackView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(defaultPadding * 9)
            $0.trailing.equalToSuperview().inset(defaultPadding * 2)
        }

        leadingButton.snp.makeConstraints {
            $0.size.equalTo(socialImageSize)
        }

        trailingButton.snp.makeConstraints {
            $0.size.equalTo(socialImageSize)
        }
    }

}
