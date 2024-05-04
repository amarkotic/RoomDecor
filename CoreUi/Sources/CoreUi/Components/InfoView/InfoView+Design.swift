import UIKit
import SnapKit

extension InfoView {

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

        labelView = UILabel()
        stackView.addArrangedSubview(labelView)
    }

    public func styleViews() {
        backgroundColor = .black.withAlphaComponent(0.2)

        stackView.spacing = 4
        stackView.alignment = .center
        stackView.roundAllCorners(withRadius: cornerRadius)
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8)
        stackView.isLayoutMarginsRelativeArrangement = true

        iconView.image = UIImage(systemImage: .info)
        iconView.tintColor = .white

        labelView.font = UIFont(with: .futura, size: 16)
        labelView.textAlignment = .center
    }

    public func defineLayoutForViews() {
        stackView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.centerX.equalToSuperview()
        }

        iconView.snp.makeConstraints {
            $0.size.equalTo(imageViewSize)
        }
    }

}
