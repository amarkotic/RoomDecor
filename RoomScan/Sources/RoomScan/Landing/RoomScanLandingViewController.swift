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

    var navBarView: NavBarView!
    var collectionView: UICollectionView!
    var startRoomScanButton: UIButton!

    private let presenter: RoomScanLandingPresenter!
    private var disposables = Set<AnyCancellable>()
    private var dataSource: DataSource!

    private var onItemSelectedSubject = PassthroughSubject<RoomScanViewModel, Never>()

    public init(presenter: RoomScanLandingPresenter) {
        self.presenter = presenter

        super.init(nibName: nil, bundle: nil)
    }

    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()

        buildViews()
        makeDataSource()
        set(items: presenter.roomScanModels)
        bindViews()
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.navigationBar.isHidden = true
        set(items: presenter.roomScanModels)
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
                self?.presenter.startRoomScanTapped()
            }
            .store(in: &disposables)
    }

    private func set(items: [RoomScanViewModel]) {
        updateSnapshot(items: items)
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
