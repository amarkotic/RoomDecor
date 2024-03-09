import Combine
import UIKit

class CircleSpinnerView: UIView {

    let circularPath = UIBezierPath(
        arcCenter: CGPoint(x: 0, y: 0),
        radius: 12,
        startAngle: .pi / 3,
        endAngle: .pi * 3,
        clockwise: true
    )

    var progressBar: CAShapeLayer!

    private var animationEndedSubject = PassthroughSubject<Void, Never>()

    var animationEnded: AnyPublisher<Void, Never> {
        animationEndedSubject
            .delay(for: .milliseconds(500), scheduler: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        buildViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func animateProgressBar() {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.delegate = self
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = 2.0
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        progressBar.add(animation, forKey: "animation")
    }

}

extension CircleSpinnerView: CAAnimationDelegate {

    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        animationEndedSubject.send(())
    }

}

extension CircleSpinnerView {

    func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }

    func createViews() {
        progressBar = CAShapeLayer()
        layer.addSublayer(progressBar)
    }

    func styleViews() {
        progressBar.path = circularPath.cgPath
        progressBar.fillColor = .none
        progressBar.strokeColor = UIColor.white.cgColor
        progressBar.lineWidth = 2
        progressBar.lineCap = CAShapeLayerLineCap.round
        progressBar.strokeEnd = 0
    }

    func defineLayoutForViews() { }

}
