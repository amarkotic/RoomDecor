import Combine
import UIKit

struct BarItemGesturePublisher: Publisher {

    typealias Output = GestureType
    typealias Failure = Never

    private let barItem: UIBarButtonItem

    init(barItem: UIBarButtonItem) {
        self.barItem = barItem
    }

    func receive<S>(subscriber: S) where S: Subscriber,
    GesturePublisher.Failure == S.Failure,
    GesturePublisher.Output == S.Input {
        let subscription = BarItemGestureSubscription(subscriber: subscriber, barItem: barItem)
        subscriber.receive(subscription: subscription)
    }

}
