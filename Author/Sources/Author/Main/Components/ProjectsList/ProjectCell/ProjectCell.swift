import UIKit

class ProjectCell: UICollectionViewCell {

    static let reuseIdentifier = String(describing: ProjectCell.self)
    static let cellSize = CGSize(width: 300, height: 200)

    var cardView: ProjectCardView!

    public override init(frame: CGRect) {
        super.init(frame: frame)

        buildViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(viewModel: ProjectModel) {
        cardView.set(viewModel: viewModel)
    }

}
