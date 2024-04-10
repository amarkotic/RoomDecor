import Combine
import UIKit
import SnapKit

class SliderView: UIView {

    let defaultPadding: CGFloat = 6
    let centerOffset: CGFloat = 64
    let cornerRadius: CGFloat = 28
    let sliderImageSize = CGSize(width: 44, height: 44)

    var contentView: UIView!
    var textView: SliderTextView!
    var sliderImageView: UIImageView!
    var finalSliderImageView: UIImageView!
    var checkmarkSpinnerView: CheckmarkSpinnerView!

    var contentLeadingConstraint: Constraint!
    var contentTrailingConstraint: Constraint!

    var stateChanged: AnyPublisher<Void, Never> {
        checkmarkSpinnerView
            .stateChanged
            .eraseToAnyPublisher()
    }

    init() {
        super.init(frame: .zero)

        buildViews()
        addGestureRecognizer()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addGestureRecognizer() {
        let gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(slide))
        sliderImageView.addGestureRecognizer(gestureRecognizer)
    }

    @objc private func slide(with gestureRecognizer: UIGestureRecognizer) {
        guard let sliderView = gestureRecognizer.view else { return }

        let minHorizontalValue = defaultPadding
        let maxHorizontalValue = frame.width - sliderImageSize.width - defaultPadding

        let sliderPosition = gestureRecognizer.location(in: sliderView)
        let sliderHorizontalPosition = sliderView.frame.origin.x + sliderPosition.x
        let updatedSliderPosition = calculateSliderPosition(
            sliderHorizontalPosition,
            minHorizontalValue: minHorizontalValue,
            maxHorizontalValue: maxHorizontalValue)
        sliderView.frame.origin.x = updatedSliderPosition
        updateTextOpacity(with: updatedSliderPosition)

        if gestureRecognizer.state == .ended {
            if updatedSliderPosition == maxHorizontalValue {
                animateStateSwitch()
            } else {
                animateSliderReset(sliderView, minHorizontalValue: minHorizontalValue)
            }
        }
    }

    private func calculateSliderPosition(
        _ sliderHorizontalPosition: CGFloat,
        minHorizontalValue: CGFloat,
        maxHorizontalValue: CGFloat
    ) -> CGFloat {
        if sliderHorizontalPosition < minHorizontalValue {
            return minHorizontalValue
        } else if sliderHorizontalPosition > maxHorizontalValue {
            return maxHorizontalValue
        } else {
            return sliderHorizontalPosition
        }
    }

    private func updateTextOpacity(with sliderPosition: CGFloat) {
        let translatedFrameCenter = frame.width / 2 - centerOffset
        let alpha = (translatedFrameCenter - sliderPosition) / 100
        textView.primaryTitleLabel.alpha = alpha
        textView.secondaryTitleLabel.alpha = alpha
    }

}

extension SliderView {

    private func animateSliderReset(_ sliderView: UIView, minHorizontalValue: CGFloat) {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut) {
            sliderView.frame.origin.x = minHorizontalValue
            self.updateTextOpacity(with: sliderView.frame.origin.x)
        }
    }

    private func animateStateSwitch() {
        textView.isHidden = true
        sliderImageView.isHidden = true
        finalSliderImageView.isHidden = false
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut) {
            self.finalSliderImageView.alpha = 0
            self.contentLeadingConstraint.deactivate()
            self.contentTrailingConstraint.deactivate()
            self.contentView.layoutIfNeeded()
        } completion: { [weak self] _ in
            self?.checkmarkSpinnerView.animateSpinner()
        }
    }

}

extension SliderView {

    func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }

    func createViews() {
        contentView = UIView()
        addSubview(contentView)

        textView = SliderTextView()
        contentView.addSubview(textView)

        sliderImageView = UIImageView()
        contentView.addSubview(sliderImageView)

        finalSliderImageView = UIImageView()
        contentView.addSubview(finalSliderImageView)

        checkmarkSpinnerView = CheckmarkSpinnerView()
        contentView.addSubview(checkmarkSpinnerView)
    }

    func styleViews() {
        contentView.clipsToBounds = true
        contentView.roundAllCorners(withRadius: cornerRadius)
        contentView.backgroundColor = .black

        sliderImageView.image = UIImage(with: .slider)
        sliderImageView.isUserInteractionEnabled = true

        finalSliderImageView.image = UIImage(with: .slider)
        finalSliderImageView.isHidden = true
    }

    func defineLayoutForViews() {
        contentView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.centerX.equalToSuperview()
            contentLeadingConstraint = $0.leading.equalToSuperview().constraint
            contentTrailingConstraint = $0.trailing.equalToSuperview().constraint
        }

        textView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }

        sliderImageView.snp.makeConstraints {
            $0.leading.top.bottom.equalToSuperview().inset(defaultPadding)
            $0.size.equalTo(sliderImageSize)
        }

        finalSliderImageView.snp.makeConstraints {
            $0.leading.greaterThanOrEqualToSuperview().inset(defaultPadding)
            $0.top.trailing.bottom.equalToSuperview().inset(defaultPadding)
            $0.size.equalTo(sliderImageSize)
        }

        checkmarkSpinnerView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }

    }

}
