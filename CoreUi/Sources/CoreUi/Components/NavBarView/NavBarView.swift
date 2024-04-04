import UIKit
import Combine

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
