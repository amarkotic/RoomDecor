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
        UIView.animate(withDuration: 0.3) {
            self.frameImageView.transform = .identity.scaledBy(x: 1.1, y: 1.1)
        } completion: { _ in
            UIView.animate(withDuration: 0.3) {
                self.frameImageView.transform = .identity.scaledBy(x: 0.9, y: 0.9)
            } completion: { _ in
                UIView.animate(withDuration: 0.3, delay: 0.2) {
                    self.sofaImageView.alpha = 0
                    self.frameImageView.alpha = 0
                } completion: { _ in
                    completionHandler()
                }
            }
        }
    }

}
