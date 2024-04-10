import UIKit
import SnapKit

extension DividerView {

    public func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }

    public func createViews() {}

    public func styleViews() {
        backgroundColor = color
    }

    public func defineLayoutForViews() {
        switch axis {
        case .horizontal:
            self.snp.makeConstraints {
                $0.height.equalTo(thickness)
            }
        case .vertical:
            self.snp.makeConstraints {
                $0.width.equalTo(thickness)
            }
        }
    }

}
