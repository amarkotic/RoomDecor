import UIKit

class SliderTextView: UIView {

    let defaultSpacing: CGFloat = 4

    var stackView: UIStackView!
    var primaryTitleLabel: UILabel!
    var secondaryTitleLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)

        buildViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        buildViews()
    }

    func set(title: String) {
        primaryTitleLabel.text = title
    }

}

extension SliderTextView {

    func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }

    func createViews() {
        stackView = UIStackView()
        addSubview(stackView)

        primaryTitleLabel = UILabel()
        stackView.addArrangedSubview(primaryTitleLabel)

        secondaryTitleLabel = UILabel()
        stackView.addArrangedSubview(secondaryTitleLabel)
    }

    func styleViews() {
        stackView.axis = .vertical
        stackView.spacing = defaultSpacing
        stackView.alignment = .center

        primaryTitleLabel.textColor = .white

        secondaryTitleLabel.textColor = .white
        secondaryTitleLabel.text = LocalizableStrings.moduleSwitchSlideToConfirm.localized
    }

    func defineLayoutForViews() {
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

}
