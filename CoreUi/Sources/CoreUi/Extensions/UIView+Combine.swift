import UIKit
import Combine

public extension UIView {

    func gesture(_ gestureType: GestureType) -> GesturePublisher {
        GesturePublisher(view: self, gestureType: gestureType)
    }

    var tap: GesturePublisher {
        gesture(.tap())
    }

    func throttledTap(for interval: Double = 0.5) -> AnyPublisher<GesturePublisher.Output, Never> {
        tap
            .throttle(for: .seconds(interval), scheduler: DispatchQueue.main, latest: true)
            .eraseToAnyPublisher()
    }

}
