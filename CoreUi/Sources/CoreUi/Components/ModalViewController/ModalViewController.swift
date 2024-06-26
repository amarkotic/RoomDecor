import UIKit

public class ModalViewController: UIViewController {

    let childViewController: UIViewController

    var contentView: UIView!

    public override func viewDidLoad() {
        super.viewDidLoad()

        buildViews()
        configureSheetPresentation()
    }

    public init(childViewController: UIViewController) {
        self.childViewController = childViewController

        super.init(nibName: nil, bundle: nil)
    }

    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: - Setup UISheetPresentationController
extension ModalViewController {

    private func configureSheetPresentation() {
        if let presentationController = presentationController as? UISheetPresentationController {
            presentationController.detents = [.custom { [weak self] _ in
                return self?.preferredContentSize.height ?? 0
            }]
            presentationController.prefersGrabberVisible = true
            presentationController.largestUndimmedDetentIdentifier = .medium
        }
    }

}
