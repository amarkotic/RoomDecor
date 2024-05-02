import UIKit
import SnapKit
import CoreUi

extension NotificationView {

    func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }

    func createViews() {
        stackView = UIStackView()
        addSubview(stackView)

        labelOne = UILabel()
        stackView.addArrangedSubview(labelOne)

        labelTwo = UILabel()
        stackView.addArrangedSubview(labelTwo)

        labelThree = UILabel()
        stackView.addArrangedSubview(labelThree)
    }

    func styleViews() {
        backgroundColor = .beige
        roundAllCorners(withRadius: cornerRadius)

        stackView.axis = .vertical
        stackView.spacing = 12

        labelOne.font = UIFont(with: .futura, size: 16)
        labelOne.text = LocalizableStrings.noLidarSupportPartOne.localized
        labelOne.textColor = .black
        labelOne.textAlignment = .center
        labelOne.numberOfLines = 0

        labelTwo.font = UIFont(with: .futura, size: 16)
        labelTwo.text = LocalizableStrings.noLidarSupportPartTwo.localized
        labelTwo.textColor = .black
        labelTwo.textAlignment = .center
        labelTwo.numberOfLines = 0

        labelThree.font = UIFont(with: .futura, size: 20)
        labelThree.text = LocalizableStrings.noLidarSupportPartThree.localized
        labelThree.textColor = .black
        labelThree.textAlignment = .center
        labelThree.numberOfLines = 0
    }

    func defineLayoutForViews() {
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(defaultPadding * 2)
        }
    }

}
