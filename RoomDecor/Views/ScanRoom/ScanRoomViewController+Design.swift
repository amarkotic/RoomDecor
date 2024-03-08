import UIKit
import RoomPlan
import SnapKit

extension ScanRoomViewController {

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

        switchButton = UIButton()
        view.addSubview(switchButton)
    }

    public func styleViews() {
        shareButton.setTitle(LocalizableStrings.share.localized, for: .normal)
        shareButton.setTitleColor(.white, for: .normal)
        shareButton.backgroundColor = .black
        shareButton.layer.cornerRadius = 4

        switchButton.backgroundColor = .lightGray
        switchButton.layer.cornerRadius = 12
    }

    public func defineLayoutForViews() {
        roomCaptureView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        shareButton.snp.makeConstraints {
            $0.bottom.leading.equalToSuperview().inset(30)
            $0.size.equalTo(shareButtonSize)
        }

        switchButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(70)
            $0.trailing.equalToSuperview().inset(30)
            $0.size.equalTo(CGSize(width: 24, height: 24))
        }
    }

}
