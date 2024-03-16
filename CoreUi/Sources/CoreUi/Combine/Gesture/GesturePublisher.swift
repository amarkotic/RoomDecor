import Combine
import UIKit

public struct GesturePublisher: Publisher {

    public typealias Output = GestureType
    public typealias Failure = Never

    private let view: UIView
    private let gestureType: GestureType

    public init(view: UIView, gestureType: GestureType) {
        self.view = view
        self.gestureType = gestureType
    }

    public func receive<S>(subscriber: S) where
        S: Subscriber,
        GesturePublisher.Failure == S.Failure,
        GesturePublisher.Output == S.Input {
        let subscription = GestureSubscription(subscriber: subscriber, view: view, gestureType: gestureType)
        subscriber.receive(subscription: subscription)
    }

}
