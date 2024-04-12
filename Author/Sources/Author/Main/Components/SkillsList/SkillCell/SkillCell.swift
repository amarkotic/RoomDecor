import Combine
import UIKit

class SkillCell: UICollectionViewCell {

    static let reuseIdentifier = String(describing: SkillCell.self)

    var cardView: SkillCardView!

    public override init(frame: CGRect) {
        super.init(frame: frame)

        buildViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(viewModel: SkillModel) {
        cardView.set(viewModel: viewModel)
    }

}
