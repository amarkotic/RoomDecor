import Combine
import UIKit

class BarItemGestureSubscription<S: Subscriber>: Subscription where S.Input == GestureType, S.Failure == Never {

    private var subscriber: S?
    private var barItem: UIBarButtonItem
    private var gestureType: GestureType = .tap()

    init(subscriber: S, barItem: UIBarButtonItem) {
        self.subscriber = subscriber
        self.barItem = barItem

        configureGesture()
    }

    func request(_ demand: Subscribers.Demand) { }

    func cancel() {
        subscriber = nil
    }

    private func configureGesture() {
        barItem.target = self
        barItem.action = #selector(handler)
    }

    @objc private func handler() {
        _ = subscriber?.receive(gestureType)
    }

}
