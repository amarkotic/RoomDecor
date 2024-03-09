import Combine
import UIKit

class SwitchModuleIcon: UIView {

    let defaultPadding: CGFloat = 6
    let cornerRadius: CGFloat = 20
    let imageViewSize: CGSize = CGSize(width: 40, height: 40)

    var imageView: UIImageView!

    private let iconInteractionSubject = PassthroughSubject<SwitchModuleInteractionType, Never>()

    var iconInteraction: AnyPublisher<SwitchModuleInteractionType, Never> {
        iconInteractionSubject
            .eraseToAnyPublisher()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        buildViews()
        addGestureRecognizer()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addGestureRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(shortTap))
        addGestureRecognizer(tapGestureRecognizer)

        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPressed))
        addGestureRecognizer(longPressRecognizer)
    }

    @objc private func shortTap(gestureReconizer: UITapGestureRecognizer) {
        iconInteractionSubject.send(.tap)
    }

    @objc private func longPressed(gestureReconizer: UILongPressGestureRecognizer) {
        guard gestureReconizer.state == .began else { return }

        iconInteractionSubject.send(.longPress)
    }

}

extension SwitchModuleIcon {

    func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }

    func createViews() {
        imageView = UIImageView()
        addSubview(imageView)
    }

    func styleViews() {
        imageView.image = UIImage(with: .avatar)
        imageView.tintColor = .black
        imageView.layer.cornerRadius = cornerRadius
        imageView.layer.borderColor = UIColor.gray.cgColor
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 3
    }

    func defineLayoutForViews() {
        imageView.snp.makeConstraints {
            $0.size.equalTo(imageViewSize)
        }
    }

}
