import UIKit
import Combine
import Core
import CoreUi

public class VirtualObjectLandingViewController: UIViewController {

    private typealias DataSource = UICollectionViewDiffableDataSource<Section, VirtualObjectType>
    private typealias DataSourceSnapshot = NSDiffableDataSourceSnapshot<Section, VirtualObjectType>

    let defaultPadding: CGFloat = 8
    let navBarHeight: CGFloat = 60

    var navBarView: NavBarView!
    var dividerView: DividerView!
    var collectionView: UICollectionView!
    var loadingView: UIView!
    var loadingIndicator: UIActivityIndicatorView!

    private let virtualObjects = VirtualObjectType.allCases
    private let presenter: VirtualObjectLandingPresenter!

    private var disposables = Set<AnyCancellable>()
    private var dataSource: DataSource!
    private var onItemSelectedSubject = PassthroughSubject<VirtualObjectType, Never>()

    public init(presenter: VirtualObjectLandingPresenter) {
        self.presenter = presenter

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()

        buildViews()
        makeDataSource()
        updateSnapshot(items: virtualObjects)
        bindViews()
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.navigationBar.isHidden = true
    }

    public override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        hideLoader()
    }

    private func bindViews() {
        navBarView
            .iconInteraction
            .sink { [weak self] interaction in
                self?.presenter.switchButtonInteracted(with: interaction)
            }
            .store(in: &disposables)

        onItemSelectedSubject
            .sink { [weak self] item in
                guard let self else { return }

                self.showLoader()

                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    self.presenter.startVirtualObject(for: item)
                }
            }
            .store(in: &disposables)
    }

    private func updateSnapshot(items: [VirtualObjectType]) {
        var snapshot = DataSourceSnapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(items)
        dataSource.apply(snapshot, animatingDifferences: true)
    }

    private func makeDataSource() {
        dataSource = DataSource(
            collectionView: collectionView,
            cellProvider: { (collectionView, indexPath, item) -> UICollectionViewCell? in
                guard
                    let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: VirtualObjectCell.reuseIdentifier,
                        for: indexPath) as? VirtualObjectCell
                else { return nil }

                cell.set(type: item)

                return cell
            })
    }

    private func showLoader() {
        loadingView.isHidden = false
        loadingIndicator.startAnimating()
    }

    private func hideLoader() {
        loadingView.isHidden = true
        loadingIndicator.stopAnimating()
    }

}

extension VirtualObjectLandingViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {

    public func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let insets = (collectionViewLayout as? UICollectionViewFlowLayout)?.sectionInset ?? .zero
        let width = collectionView.bounds.width / 2 - insets.left - insets.right
        let height = width
        return CGSize(width: width, height: height)
    }

    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = dataSource.itemIdentifier(for: indexPath) else { return }

        onItemSelectedSubject.send(item)
    }

}
