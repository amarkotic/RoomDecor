import UIKit
import RoomPlan
import SnapKit
import CoreUi

extension RoomScanViewController {

    func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }

    public func createViews() {
        roomCaptureView = RoomCaptureView()
        view.addSubview(roomCaptureView)
        roomCaptureView.captureSession.delegate = self

        saveButton = UIButton()
        view.addSubview(saveButton)

        saveLoadingIndicator = UIActivityIndicatorView(style: .large)
        saveButton.addSubview(saveLoadingIndicator)

        shareButton = UIButton()
        view.addSubview(shareButton)

        shareLoadingIndicator = UIActivityIndicatorView(style: .large)
        shareButton.addSubview(shareLoadingIndicator)
    }

    public func styleViews() {
        navigationController?.setNavigationBarHidden(false, animated: false)

        saveButton.setTitle(CoreUi.LocalizableStrings.save.localized, for: .normal)
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.backgroundColor = .black
        saveButton.roundAllCorners(withRadius: cornerRadius)
        saveButton.isHidden = true

        shareButton.setTitle(CoreUi.LocalizableStrings.share.localized, for: .normal)
        shareButton.setTitleColor(.white, for: .normal)
        shareButton.backgroundColor = .black
        shareButton.roundAllCorners(withRadius: cornerRadius)
        shareButton.layer.opacity = 0
    }

    public func defineLayoutForViews() {
        roomCaptureView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        saveButton.snp.makeConstraints {
            $0.bottom.leading.equalToSuperview().inset(defaultPadding * 3)
        }

        saveButton.snp.makeConstraints {
            $0.size.equalTo(buttonSize)
        }

        saveLoadingIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
        }

        shareButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(defaultPadding * 2)
            $0.bottom.equalToSuperview().inset(defaultPadding * 3)
            $0.height.equalTo(buttonSize.height)
        }

        shareLoadingIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }

}
