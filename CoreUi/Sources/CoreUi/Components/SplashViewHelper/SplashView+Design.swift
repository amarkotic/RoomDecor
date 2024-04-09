import UIKit
import SnapKit

extension SplashView {

    func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }

    func createViews() {
        frameImageView = UIImageView()
        addSubview(frameImageView)

        sofaImageView = UIImageView()
        addSubview(sofaImageView)
    }

    func styleViews() {
        backgroundColor = .beige

        frameImageView.image = UIImage(named: BundleImage.frame.rawValue, in: .main, with: nil)
        frameImageView.contentMode = .scaleToFill

        sofaImageView.image = UIImage(named: BundleImage.sofa.rawValue, in: .main, with: nil)
        sofaImageView.contentMode = .scaleToFill
    }

    func defineLayoutForViews() {
        frameImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(frameImageSize)
        }

        sofaImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(sofaImageSize)
        }
    }

}
