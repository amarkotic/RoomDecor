import UIKit
import SnapKit

extension ErrorView {

    func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }

    public func createViews() {
        stackView = UIStackView()
        addSubview(stackView)

        iconView = UIImageView()
        stackView.addArrangedSubview(iconView)

        titleLabelView = UILabel()
        stackView.addArrangedSubview(titleLabelView)

        descriptionLabelView = UILabel()
        stackView.addArrangedSubview(descriptionLabelView)

        button = UIButton()
        stackView.addArrangedSubview(button)
    }

    public func styleViews() {
        backgroundColor = .black.withAlphaComponent(0.7)

        stackView.backgroundColor = .white
        stackView.roundAllCorners(withRadius: cornerRadius)
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(
            top: defaultPadding,
            leading: defaultPadding,
            bottom: defaultPadding,
            trailing: defaultPadding)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.alignment = .center

        iconView.image = UIImage(systemImage: .error)
        iconView.tintColor = .black
        iconView.contentMode = .scaleAspectFill

        titleLabelView.font = UIFont(with: .futura, size: 16)
        titleLabelView.textColor = .black
        titleLabelView.textAlignment = .center
        titleLabelView.numberOfLines = 0

        descriptionLabelView.font = UIFont(with: .futura, size: 14)
        descriptionLabelView.textColor = .black.withAlphaComponent(0.8)
        descriptionLabelView.textAlignment = .center
        descriptionLabelView.numberOfLines = 0

        button.setTitle(LocalizableStrings.confirm.localized, for: .normal)
        button.backgroundColor = .black
        button.tintColor = .white
        button.roundAllCorners(withRadius: 4)
    }

    public func defineLayoutForViews() {
        stackView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(popupWidth)
        }

        iconView.snp.makeConstraints {
            $0.size.equalTo(imageViewSize)
        }

        button.snp.makeConstraints {
            $0.size.equalTo(buttonSize)
        }
    }

}
