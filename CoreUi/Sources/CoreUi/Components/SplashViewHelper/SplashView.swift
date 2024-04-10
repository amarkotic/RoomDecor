import UIKit

public class SplashView: UIView {

    let frameImageSize = CGSize(width: 240, height: 230)
    let sofaImageSize = CGSize(width: 140, height: 100)

    var frameImageView: UIImageView!
    var sofaImageView: UIImageView!

    public override init(frame: CGRect) {
        super.init(frame: frame)

        buildViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func animate(completionHandler: @escaping () -> Void) {
        UIView.animate(withDuration: 0.5) {
            self.frameImageView.transform = .identity.scaledBy(x: 1.2, y: 1.2)
        } completion: { _ in
            UIView.animate(withDuration: 0.5) {
                self.frameImageView.transform = .identity
            } completion: { _ in
                UIView.animate(withDuration: 1, delay: 0.2, options: [.curveEaseOut]) {
                    self.sofaImageView.alpha = 0
                    self.frameImageView.alpha = 0
                } completion: { _ in
                    UIView.animate(withDuration: 0.5) {
                        self.alpha = 0
                    } completion: { _ in
                        completionHandler()
                    }
                }
            }
        }
    }

}
