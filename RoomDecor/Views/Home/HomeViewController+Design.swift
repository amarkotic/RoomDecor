import UIKit
import SnapKit

extension HomeViewController {

    func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }

    public func createViews() {
        containerView = UIStackView()
        view.addSubview(containerView)

        addVirtualObjectButton = UIButton()
        containerView.addArrangedSubview(addVirtualObjectButton)

        create3DModelButton = UIButton()
        containerView.addArrangedSubview(create3DModelButton)
    }

    public func styleViews() {
        view.backgroundColor = .systemGray

        containerView.axis = .vertical
        containerView.spacing = 80

        addVirtualObjectButton.setTitle(LocalizableStrings.addVirtualObject.localized, for: .normal)
        addVirtualObjectButton.backgroundColor = .lightGray

        create3DModelButton.setTitle(LocalizableStrings.scanTheRoom.localized, for: .normal)
        create3DModelButton.backgroundColor = .lightGray
    }

    public func defineLayoutForViews() {
        containerView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.center.equalToSuperview()
        }

        addVirtualObjectButton.snp.makeConstraints {
            $0.size.equalTo(buttonSize)
        }

        create3DModelButton.snp.makeConstraints {
            $0.size.equalTo(buttonSize)
        }
    }

}
