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
            $0.height.lessThanOrEqualTo(height)
        }

        stackView.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview().inset(defaultPadding)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(defaultPadding)
        }

        sliderView.snp.makeConstraints {
            $0.height.equalTo(sliderHeight)
        }
    }

}
