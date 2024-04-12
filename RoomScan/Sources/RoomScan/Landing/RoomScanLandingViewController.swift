import UIKit
import Combine
import Core
import CoreUi

public class RoomScanLandingViewController: UIViewController {

    private typealias DataSource = UICollectionViewDiffableDataSource<Section, RoomScanViewModel>
    private typealias DataSourceSnapshot = NSDiffableDataSourceSnapshot<Section, RoomScanViewModel>

    let defaultPadding: CGFloat = 8
    let cornerRadius: CGFloat = 4
    let navBarHeight: CGFloat = 60
    let startButtonHeight: CGFloat = 60
    let arrowImageSize = CGSize(width: 150, height: 150)

    var navBarView: NavBarView!
    var topDivider: DividerView!
    var collectionView: UICollectionView!
    var startScanView: UIImageView!
    var bottomDivider: DividerView!
    var startRoomScanButton: UIButton!
    var loadingIndicator: UIActivityIndicatorView!
    var splashView: SplashView!

    private let presenter: RoomScanLandingPresenter!
    private let isModuleSwitch: Bool!
    private var disposables = Set<AnyCancellable>()
    private var dataSource: DataSource!

    private var onItemSelectedSubject = PassthroughSubject<RoomScanViewModel, Never>()

    public init(presenter: RoomScanLandingPresenter, isModuleSwitch: Bool) {
        self.presenter = presenter
        self.isModuleSwitch = isModuleSwitch

        super.init(nibName: nil, bundle: nil)
    }

    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()

        buildViews()
        makeDataSource()
        populateView()
        bindViews()
        showSplash()
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.navigationBar.isHidden = true
        populateView()
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
                self?.presenter.presentShareSheet(for: [item.url])
            }
            .store(in: &disposables)

        startRoomScanButton
            .throttledTap()
            .sink { [weak self] _ in
                guard let self else { return }

                self.showLoader()

                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    self.presenter.startRoomScanTapped()
                }
            }
            .store(in: &disposables)
    }

    private func populateView() {
        if presenter.roomScanModels.count == 0 {
            collectionView.isHidden = true
            startScanView.isHidden = false
            UIView.animate(withDuration: 1, delay: 0, options: [.autoreverse, .repeat]) {
                self.startScanView.transform = .identity.scaledBy(x: 1.3, y: 1.3)
            }
        } else {
            collectionView.isHidden = false
            startScanView.isHidden = true
            updateSnapshot(items: presenter.roomScanModels)
        }
    }

    private func updateSnapshot(items: [RoomScanViewModel]) {
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
                        withReuseIdentifier: RoomScanCell.reuseIdentifier,
                        for: indexPath) as? RoomScanCell
                else { return nil }

                cell
                    .shareTapped
                    .sink { [weak self] _ in
                        self?.onItemSelectedSubject.send(item)
                    }
                    .store(in: &cell.disposables)

                cell.set(model: item)

                return cell
            })
    }

    private func showSplash() {
        guard !isModuleSwitch else { return }

        splashView.isHidden = false
        splashView.animate { [weak self] in
            self?.splashView.isHidden = true
        }
    }

    private func showLoader() {
        loadingIndicator.isHidden = false
        loadingIndicator.startAnimating()
        startRoomScanButton.titleLabel?.isHidden = true
    }

    private func hideLoader() {
        loadingIndicator.isHidden = true
        loadingIndicator.stopAnimating()
        startRoomScanButton.titleLabel?.isHidden = false
    }

}

extension RoomScanLandingViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {

    public func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let insets = (collectionViewLayout as? UICollectionViewFlowLayout)?.sectionInset ?? .zero
        let width = collectionView.bounds.width - insets.left - insets.right
        let height = RoomScanCell.height
        return CGSize(width: width, height: height)
    }

}
