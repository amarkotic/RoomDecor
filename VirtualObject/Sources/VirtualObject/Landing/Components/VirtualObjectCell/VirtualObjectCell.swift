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
