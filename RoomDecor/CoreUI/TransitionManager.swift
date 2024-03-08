import UIKit

class TransitionManager: NSObject {

    private let screenOffset: CGFloat = 500
    private let scaleDownMultiplier: CGFloat = 0.7
    private let quarterLength = 0.25
    private let duration: TimeInterval

    init(duration: TimeInterval) {
        self.duration = duration
    }

}

extension TransitionManager: UIViewControllerAnimatedTransitioning {

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        duration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let startView = transitionContext.viewController(forKey: .from)?.view,
            let finishView = transitionContext.viewController(forKey: .to)?.view
        else {
            transitionContext.completeTransition(false)
            return
        }

        startView.clipsToBounds = true
        finishView.clipsToBounds = true
        finishView.isHidden = true

        transitionContext.containerView.backgroundColor = .gray
        transitionContext.containerView.addSubview(startView)
        transitionContext.containerView.addSubview(finishView)

        startAnimation(with: transitionContext, fromView: startView, toView: finishView)
    }

    private func startAnimation(
        with transitionContext: UIViewControllerContextTransitioning,
        fromView: UIView,
        toView: UIView
    ) {
        let scaleDown = CGAffineTransform(scaleX: scaleDownMultiplier, y: scaleDownMultiplier)
        let scaleToOriginalSize = CGAffineTransform(scaleX: 1, y: 1)
        let translateLeft = CGAffineTransform(translationX: 0 - fromView.frame.width - screenOffset, y: 0)
        let translateRight = CGAffineTransform(translationX: fromView.frame.width + screenOffset, y: 0)
        let translateToCenter = CGAffineTransform(translationX: 0, y: 0)
        toView.transform = translateRight.concatenating(scaleDown)

        UIView.animateKeyframes(withDuration: duration, delay: 0, options: .calculationModeLinear) {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: self.quarterLength) {
                fromView.transform = scaleDown
            }
            UIView.addKeyframe(withRelativeStartTime: self.quarterLength, relativeDuration: self.quarterLength * 2) {
                fromView.transform = scaleDown.concatenating(translateLeft)

                toView.isHidden = false
                toView.transform = translateToCenter.concatenating(scaleDown)
            }
            UIView.addKeyframe(withRelativeStartTime: self.quarterLength * 3, relativeDuration: self.quarterLength) {
                toView.transform = scaleToOriginalSize
            }
        } completion: { _ in
            transitionContext.completeTransition(true)
        }
    }

}
