import UIKit
import Combine
import SnapKit

public class NavBarView: UIView {

    let defaultPadding: CGFloat = 16
    let imageViewSize = CGSize(width: 40, height: 40)

    var titleLabel: UILabel!
    var switchIcon: SwitchModuleIcon!

    public var iconInteraction: AnyPublisher<SwitchModuleInteractionType, Never> {
        switchIcon
            .iconInteraction
            .eraseToAnyPublisher()
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)

        buildViews()
    }

    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func set(title: String) {
        titleLabel.text = title
    }

}

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

        titleLabel.font = UIFont(name: "Futura", size: 30)
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
