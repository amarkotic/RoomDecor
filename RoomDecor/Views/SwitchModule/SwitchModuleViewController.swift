import Combine
import UIKit

class SwitchModuleViewController: UIViewController {

    let defaultMargin: CGFloat = 16
    let defaultSpacing: CGFloat = 22

    var stackView: UIStackView!
    var authorInfoView: AuthorInfoView!
    var sliderView: SliderView!

    var onDismiss: ((SheetDissmisType) -> Void)?

    private var disposables = Set<AnyCancellable>()
    private var presenter: SwitchModulePresenter!

    var stateChanged: AnyPublisher<Void, Never> {
        sliderView
            .stateChanged
            .eraseToAnyPublisher()
    }

    convenience init(presenter: SwitchModulePresenter) {
        self.init()

        self.presenter = presenter
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        onDismiss?(.normal)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        buildViews()
        bindViews()

        view.layoutIfNeeded()
        let totalHeight = view.frame.size.height
        preferredContentSize = CGSize(width: UIScreen.main.bounds.width, height: totalHeight)
    }

    private func bindViews() {
        authorInfoView
            .throttledTap()
            .sink { [weak self] _ in
                guard let self = self else { return }

                self.onDismiss?(.normal)
                self.presenter.authorViewTap()
            }
            .store(in: &disposables)

        stateChanged
            .sink { [weak self] _ in
                self?.onDismiss?(.withAnimationAfter)
            }
            .store(in: &disposables)
    }

}
