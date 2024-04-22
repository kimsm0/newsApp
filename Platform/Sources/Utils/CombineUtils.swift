/**
 @class ReadOnlyCurrentValuePublisher & CurrentValuePublisher
 @date 4/21/24
 @writer kimsoomin
 @brief
 @update history
 -
 */

import Foundation
import CombineExt
import Combine

public class ReadOnlyCurrentValuePublisher<Element>: Publisher {
    public typealias Output = Element
    public typealias Failure = Never
    
    public var value: Element {
        currentValueRelay.value
    }
    
    fileprivate let currentValueRelay: CurrentValueRelay<Output>
    fileprivate init(_ initialValue: Element){
        currentValueRelay = CurrentValueRelay(initialValue)
    }
    
    public func receive<S>(subscriber: S) where S : Subscriber, Never == S.Failure, Element == S.Input {
        currentValueRelay.receive(subscriber: subscriber)
    }
}

public final class CurrentValuePublisher<Element>: ReadOnlyCurrentValuePublisher<Element> {
    public typealias Output = Element
    public typealias Failure = Never
    
    public override init(_ initialValue: Element){
        super.init(initialValue)
    }
    
    public func send(_ value: Element){
        currentValueRelay.accept(value)
    }
}
