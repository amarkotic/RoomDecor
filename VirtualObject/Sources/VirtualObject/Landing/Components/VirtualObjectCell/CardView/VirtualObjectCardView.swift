import UIKit
import SceneKit
import SnapKit

class VirtualObjectCardView: UIView {

    let defaultPadding: CGFloat = 16
    let cornerRadius: CGFloat = 16

    var stackView: UIStackView!
    var imageView: UIImageView!
    var titleLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)

        buildViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(type: VirtualObjectType) {
        titleLabel.text = type.title
        guard let url = Bundle.module.url(forResource: type.rawValue, withExtension: "usdz") else { return }

        imageView.load3DModelThumbnail(from: url)
    }

}

extension VirtualObjectCardView {

    func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }

    func createViews() {
        stackView = UIStackView()
        addSubview(stackView)

        imageView = UIImageView()
        stackView.addArrangedSubview(imageView)

        titleLabel = UILabel()
        stackView.addArrangedSubview(titleLabel)
    }

    func styleViews() {
        backgroundColor = .white
        roundAllCorners(withRadius: cornerRadius)
        addBorder(width: 2, color: .black)

        stackView.axis = .vertical
        stackView.alignment = .center

        imageView.contentMode = .scaleAspectFit

        titleLabel.textColor = .black
        titleLabel.font = UIFont(name: "Futura", size: 18)
    }

    func defineLayoutForViews() {
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(defaultPadding)
        }
    }

}
