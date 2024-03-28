import UIKit

class VirtualObjectCell: UICollectionViewCell {

    static let reuseIdentifier = String(describing: VirtualObjectCell.self)

    var cardView: VirtualObjectCardView!

    public override init(frame: CGRect) {
        super.init(frame: frame)

        buildViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(type: VirtualObjectType) {
        cardView.set(type: type)
    }

}

extension VirtualObjectCell {

    public func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }

    public func createViews() {
        cardView = VirtualObjectCardView()
        addSubview(cardView)
    }

    public func styleViews() {}

    public func defineLayoutForViews() {
        cardView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

}
