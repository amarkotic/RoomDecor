import UIKit
import RoomPlan
import SnapKit

extension Create3DModelViewController {

    func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }

    public func createViews() {
        roomCaptureView = RoomCaptureView()
        view.addSubview(roomCaptureView)
        roomCaptureView.captureSession.delegate = self

        shareButton = UIButton()
        view.addSubview(shareButton)
    }

    public func styleViews() {
        shareButton.setTitle("Share", for: .normal)
        shareButton.setTitleColor(.white, for: .normal)
        shareButton.backgroundColor = .black
        shareButton.layer.cornerRadius = 4
    }

    public func defineLayoutForViews() {
        roomCaptureView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        shareButton.snp.makeConstraints {
            $0.bottom.leading.equalToSuperview().inset(30)
            $0.size.equalTo(shareButtonSize)
        }
    }

}
