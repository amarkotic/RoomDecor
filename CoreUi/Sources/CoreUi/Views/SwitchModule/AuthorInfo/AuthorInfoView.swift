import UIKit

class AuthorInfoView: UIView {

    let defaultSpacing: CGFloat = 12
    let cornerRadius: CGFloat = 20
    let imageSize = CGSize(width: 40, height: 40)

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

}

extension AuthorInfoView {

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
        stackView.spacing = defaultSpacing

        imageView.image = UIImage(systemImage: .avatar)
        imageView.tintColor = .black
        imageView.roundAllCorners(withRadius: cornerRadius)
        imageView.addBorder(width: 3, color: .gray)

        titleLabel.textColor = .black
        titleLabel.text = LocalizableStrings.author.localized
    }

    func defineLayoutForViews() {
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(imageSize.height)
        }

        imageView.snp.makeConstraints {
            $0.size.equalTo(imageSize)
        }
    }

}
