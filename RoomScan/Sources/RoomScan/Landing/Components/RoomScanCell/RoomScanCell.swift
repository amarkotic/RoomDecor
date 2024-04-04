import Combine
import UIKit
import CoreUi

class RoomScanCell: UICollectionViewCell {

    static let reuseIdentifier = String(describing: RoomScanCell.self)
    static let height: CGFloat = 120

    var cardView: RoomScanCardView!

    var disposables = Set<AnyCancellable>()
    var shareTapped: AnyPublisher<GesturePublisher.Output, Never> {
        cardView
            .shareButton
            .throttledTap()
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)

        buildViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func prepareForReuse() {
        super.prepareForReuse()

        disposables.removeAll()
    }

    func set(model: RoomScanViewModel) {
        cardView.set(model: model)
    }

}
