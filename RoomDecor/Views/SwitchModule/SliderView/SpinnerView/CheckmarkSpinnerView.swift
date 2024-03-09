import Combine
import UIKit

class CheckmarkSpinnerView: UIView {

    let checkmarkImageSize = CGSize(width: 24, height: 24)

    var spinnerView: CircleSpinnerView!
    var checkmarkImageView: UIImageView!
    var checkmarkOverlayView: UIView!

    private var disposables = Set<AnyCancellable>()

    private var stateChangedSubject = PassthroughSubject<Void, Never>()

    var stateChanged: AnyPublisher<Void, Never> {
        stateChangedSubject
            .delay(for: .milliseconds(200), scheduler: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

    init() {
        super.init(frame: .zero)

        buildViews()
        bindViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func bindViews() {
        spinnerView
            .animationEnded
            .sink { [weak self] in
                self?.animateCheckmark()
            }
            .store(in: &disposables)
    }

    func set(backgroundColor: UIColor) {
        checkmarkOverlayView.backgroundColor = backgroundColor
    }

    func animateSpinner() {
        self.spinnerView.isHidden = false
        self.spinnerView.animateProgressBar()
    }

    private func animateCheckmark() {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut) {
            self.spinnerView.isHidden = true
            self.checkmarkImageView.isHidden = false
            self.checkmarkOverlayView.isHidden = false
            let translationTransformation = CGAffineTransform(translationX: self.checkmarkImageSize.width * 2, y: 0)
            let scaleTrasformation = CGAffineTransform(scaleX: 0.3, y: 1)
            self.checkmarkOverlayView.transform = translationTransformation.concatenating(scaleTrasformation)
        } completion: { [weak self] _ in
            self?.stateChangedSubject.send(())
        }
    }

}

extension CheckmarkSpinnerView {

    func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }

    func createViews() {
        spinnerView = CircleSpinnerView()
        addSubview(spinnerView)

        checkmarkImageView = UIImageView()
        addSubview(checkmarkImageView)

        checkmarkOverlayView = UIView()
        checkmarkImageView.addSubview(checkmarkOverlayView)
    }

    func styleViews() {
        checkmarkImageView.image = UIImage(with: .checkmark)
        checkmarkImageView.isHidden = true

        spinnerView.isHidden = true
    }

    func defineLayoutForViews() {
        spinnerView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }

        checkmarkImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(checkmarkImageSize)
        }

        checkmarkOverlayView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

}
