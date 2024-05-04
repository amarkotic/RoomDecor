import Combine
import UIKit

public class ErrorView: UIView {

    let defaultPadding: CGFloat = 16
    let cornerRadius: CGFloat = 4
    let imageViewSize = CGSize(width: 36, height: 36)
    let buttonSize = CGSize(width: 218, height: 40)
    let popupWidth: CGFloat = 250

    var stackView: UIStackView!
    var iconView: UIImageView!
    var titleLabelView: UILabel!
    var descriptionLabelView: UILabel!
    var button: UIButton!

    public var disposables = Set<AnyCancellable>()
    private var buttonTappedSubject = PassthroughSubject<Void, Never>()

    public var buttonTapped: AnyPublisher<Void, Never> {
        buttonTappedSubject
            .throttle(for: .milliseconds(100), scheduler: DispatchQueue.main, latest: true)
            .eraseToAnyPublisher()
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)

        buildViews()
        bindViews()
    }

    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func set(type: ErrorType) {
        titleLabelView.text = type.title
        descriptionLabelView.text = type.description
    }

    private func bindViews() {
        button
            .throttledTap()
            .sink { [weak self] _ in
                self?.buttonTappedSubject.send(())
            }
            .store(in: &disposables)
    }

}
