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

        stackView = UIStackView()
        view.addSubview(stackView)

        saveButton = UIButton()
        stackView.addArrangedSubview(saveButton)
        
        saveLoadingIndicator = UIActivityIndicatorView(style: .large)
        saveButton.addSubview(saveLoadingIndicator)

        shareButton = UIButton()
        stackView.addArrangedSubview(shareButton)

        shareLoadingIndicator = UIActivityIndicatorView(style: .large)
        shareButton.addSubview(shareLoadingIndicator)
    }

    public func styleViews() {
        navigationController?.setNavigationBarHidden(false, animated: false)

        stackView.spacing = 12
        stackView.distribution = .fillEqually
        stackView.isHidden = true

        saveButton.setTitle(CoreUi.LocalizableStrings.save.localized, for: .normal)
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.backgroundColor = .black
        saveButton.roundAllCorners(withRadius: cornerRadius)

        shareButton.setTitle(CoreUi.LocalizableStrings.share.localized, for: .normal)
        shareButton.setTitleColor(.white, for: .normal)
        shareButton.backgroundColor = .black
        shareButton.roundAllCorners(withRadius: cornerRadius)
    }

    public func defineLayoutForViews() {
        roomCaptureView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        stackView.snp.makeConstraints {
            $0.bottom.leading.equalToSuperview().inset(defaultPadding * 2)
            $0.leading.trailing.equalToSuperview().inset(defaultPadding * 2)
        }

        saveButton.snp.makeConstraints {
            $0.size.equalTo(buttonSize)
        }

        saveLoadingIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
        }

        shareButton.snp.makeConstraints {
            $0.size.equalTo(buttonSize)
        }

        shareLoadingIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }

}
