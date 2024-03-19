import Combine
import UIKit

public class SwitchModuleViewController: UIViewController {

    let defaultPadding: CGFloat = 16
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

    public convenience init(presenter: SwitchModulePresenter) {
        self.init()

        self.presenter = presenter
    }

    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        onDismiss?(.normal)
    }

    public override func viewDidLoad() {
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
