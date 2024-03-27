import UIKit

class RoomScanCell: UICollectionViewCell {

    static let reuseIdentifier = String(describing: RoomScanCell.self)
    static let height: CGFloat = 120

    var cardView: RoomScanCardView!

    public override init(frame: CGRect) {
        super.init(frame: frame)

        buildViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(model: RoomScanViewModel) {
        cardView.set(model: model)
    }

}

extension RoomScanCell {

    public func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }

    public func createViews() {
        cardView = RoomScanCardView()
        addSubview(cardView)
    }

    public func styleViews() {}

    public func defineLayoutForViews() {
        cardView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

}
