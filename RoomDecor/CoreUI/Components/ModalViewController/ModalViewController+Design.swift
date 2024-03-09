import UIKit
import SnapKit

extension ModalViewController {

    func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }

    func createViews() {
        contentView = UIView()
        view.addSubview(contentView)

        addChild(childViewController)
        contentView.addSubview(childViewController.view)

        childViewController.didMove(toParent: self)
        preferredContentSize = childViewController.preferredContentSize
    }

    func styleViews() {
        contentView.backgroundColor = .white
    }

    func defineLayoutForViews() {
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        childViewController.view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

}
