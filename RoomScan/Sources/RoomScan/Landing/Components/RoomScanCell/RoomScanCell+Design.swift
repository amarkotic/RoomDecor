import UIKit
import SnapKit

extension RoomScanCell {

    public func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }

    public func createViews() {
        cardView = RoomScanCardView()
        contentView.addSubview(cardView)
    }

    public func styleViews() {}

    public func defineLayoutForViews() {
        cardView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

}
