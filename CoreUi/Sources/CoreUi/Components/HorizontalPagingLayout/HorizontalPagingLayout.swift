import UIKit

public class HorizontalPagingLayout: UICollectionViewFlowLayout {

    private var leadingOffset: CGFloat!

    public convenience init(leadingOffset: CGFloat) {
        self.init()

        self.leadingOffset = leadingOffset
    }

    public override func targetContentOffset(
        forProposedContentOffset proposedContentOffset: CGPoint,
        withScrollingVelocity velocity: CGPoint
    ) -> CGPoint {
        var offsetAdjustment: CGFloat = .greatestFiniteMagnitude
        let horizontalOffset = proposedContentOffset.x
        let currentlyVisibleCells = CGRect(
            origin: CGPoint(x: proposedContentOffset.x, y: 0),
            size: collectionView?.bounds.size ?? .zero)

        super.layoutAttributesForElements(in: currentlyVisibleCells)?.forEach {
            let staticCellOffset = $0.frame.origin.x
            if abs(staticCellOffset - horizontalOffset) < abs(offsetAdjustment) {
                offsetAdjustment = staticCellOffset - horizontalOffset - leadingOffset
            }
        }

        return CGPoint(x: proposedContentOffset.x + offsetAdjustment, y: .zero)
    }

}
