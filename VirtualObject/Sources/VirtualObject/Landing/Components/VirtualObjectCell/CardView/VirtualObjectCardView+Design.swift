import UIKit
import SnapKit
import CoreUi

extension VirtualObjectCardView {

    func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }

    func createViews() {
        stackView = UIStackView()
        addSubview(stackView)

        imageView = UIImageView()
        stackView.addArrangedSubview(imageView)

        titleLabel = UILabel()
        stackView.addArrangedSubview(titleLabel)
    }

    func styleViews() {
        backgroundColor = .white
        roundAllCorners(withRadius: cornerRadius)
        addBorder(width: 2, color: .black)

        stackView.axis = .vertical
        stackView.alignment = .center

        imageView.contentMode = .scaleAspectFit

        titleLabel.textColor = .black
        titleLabel.font = UIFont(with: .futura, size: 18)
    }

    func defineLayoutForViews() {
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(defaultPadding)
        }
    }

}
