import UIKit

public class DividerView: UIView {

    public enum DividerAxis {
        case vertical
        case horizontal
    }

    let axis: DividerAxis
    let thickness: CGFloat
    let color: UIColor

    public init(
        axis: DividerAxis = .horizontal,
        thickness: CGFloat = 1.0,
        color: UIColor = .black
    ) {
        self.axis = axis
        self.thickness = thickness
        self.color = color

        super.init(frame: .zero)

        buildViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
