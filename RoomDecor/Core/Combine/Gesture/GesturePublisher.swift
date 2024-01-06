import Combine
import UIKit

struct GesturePublisher: Publisher {

    typealias Output = GestureType
    typealias Failure = Never

    private let view: UIView
    private let gestureType: GestureType

    init(view: UIView, gestureType: GestureType) {
        self.view = view
        self.gestureType = gestureType
    }

    func receive<S>(subscriber: S) where
        S: Subscriber,
        GesturePublisher.Failure == S.Failure,
        GesturePublisher.Output == S.Input {
        let subscription = GestureSubscription(subscriber: subscriber, view: view, gestureType: gestureType)
        subscriber.receive(subscription: subscription)
    }

}
