import UIKit
import SnapKit

extension NavBarView {

    func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }

    public func createViews() {
        backgroundColor = .white

        titleLabel = UILabel()
        addSubview(titleLabel)

        switchIcon = SwitchModuleIcon()
        addSubview(switchIcon)
    }

    public func styleViews() {
        backgroundColor = .white

        titleLabel.font = UIFont(with: .futura, size: 30)
        titleLabel.textColor = .black
    }

    public func defineLayoutForViews() {
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(defaultPadding)
            $0.centerY.equalToSuperview()
        }

        switchIcon.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(defaultPadding)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(imageViewSize)
        }
    }

}
