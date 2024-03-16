import Foundation
import Combine

extension Publisher {

    static func empty() -> AnyPublisher<Output, Failure> {
        Empty<Output, Failure>().eraseToAnyPublisher()
    }

    static func never() -> AnyPublisher<Output, Failure> {
        Empty<Output, Failure>(completeImmediately: false).eraseToAnyPublisher()
    }

    static func error(error: Failure) -> AnyPublisher<Output, Failure> {
        Deferred<Fail<Output, Failure>> {
            Fail<Output, Failure>(error: error)
        }.eraseToAnyPublisher()
    }

    func receiveOnBackground() -> AnyPublisher<Output, Failure> {
        receive(on: DispatchQueue.global(qos: .background))
            .eraseToAnyPublisher()
    }

    func receiveOnMain() -> AnyPublisher<Output, Failure> {
        receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }

    func subscribeOnBackground() -> AnyPublisher<Output, Failure> {
        subscribe(on: DispatchQueue.global(qos: .background))
            .eraseToAnyPublisher()
    }

    func flatMapLatest<T: Publisher>(_ transform: @escaping (Self.Output) -> T) -> AnyPublisher<T.Output, T.Failure>
    where T.Failure == Self.Failure {
        map(transform)
            .switchToLatest()
            .eraseToAnyPublisher()
    }

    // For testing purposes
    func printThread(_ tag: String = "") -> AnyPublisher<Output, Failure> {
        handleEvents(receiveOutput: { _ in
            Swift.print("\(tag) \(Thread.current) (isMain: \(Thread.current.isMainThread))")
        })
        .eraseToAnyPublisher()
    }

    func mapVoid() -> AnyPublisher<Void, Failure> {
        map { _ in () }
            .eraseToAnyPublisher()
    }

}
