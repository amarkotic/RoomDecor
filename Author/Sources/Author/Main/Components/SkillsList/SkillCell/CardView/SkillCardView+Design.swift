import UIKit
import SnapKit
import CoreUi

extension SkillCardView {

    func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }

    func createViews() {
        titleLabel = UILabel()
        addSubview(titleLabel)
    }

    func styleViews() {
        backgroundColor = .beige
        roundAllCorners(withRadius: cornerRadius)
        addBorder(width: 1, color: .black)

        titleLabel.textColor = .black
        titleLabel.font = UIFont(with: .futura, size: 12)
    }

    func defineLayoutForViews() {
        titleLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(defaultPadding)
        }
    }

}
