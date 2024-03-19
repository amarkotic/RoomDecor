import UIKit
import SceneKit
import SnapKit

class RoomScanCardView: UIView {

    let defaultPadding: CGFloat = 16

    var titleLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)

        buildViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(model: RoomScanModel) {
        titleLabel.text = model.date
    }

}

extension RoomScanCardView {

    func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }

    func createViews() {
        titleLabel = UILabel()
        addSubview(titleLabel)
    }

    func styleViews() {
        backgroundColor = .white
        layer.cornerRadius = 16
        clipsToBounds = true
        layer.borderWidth = 2
        layer.borderColor = UIColor.black.cgColor

        titleLabel.textColor = .black
        titleLabel.font = UIFont(name: "Futura", size: 18)
    }

    func defineLayoutForViews() {
        titleLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(defaultPadding)
        }
    }

}
