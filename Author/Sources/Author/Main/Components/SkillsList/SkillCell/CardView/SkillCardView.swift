import UIKit
import Core

class SkillCardView: UIView {

    let defaultPadding: CGFloat = 8
    let cornerRadius: CGFloat = 20

    var titleLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)

        buildViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(viewModel: SkillModel) {
        titleLabel.text = viewModel.name
    }

}
