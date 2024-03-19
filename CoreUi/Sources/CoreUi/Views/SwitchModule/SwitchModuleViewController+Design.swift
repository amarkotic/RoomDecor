import UIKit
import SnapKit

extension SwitchModuleViewController {

    func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }

    func createViews() {
        stackView = UIStackView()
        view.addSubview(stackView)

        authorInfoView = AuthorInfoView()
        stackView.addArrangedSubview(authorInfoView)

        sliderView = SliderView()
        stackView.addArrangedSubview(sliderView)
    }

    func styleViews() {
        view.backgroundColor = .white

        stackView.spacing = defaultSpacing
        stackView.axis = .vertical
    }

    func defineLayoutForViews() {
        view.snp.makeConstraints {
            $0.height.equalTo(116)
        }

        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(defaultPadding)
        }

        sliderView.snp.makeConstraints {
            $0.height.equalTo(56)
        }
    }

}
