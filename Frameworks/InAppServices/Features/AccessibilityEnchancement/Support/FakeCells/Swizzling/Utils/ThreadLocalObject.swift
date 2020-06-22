#if MIXBOX_ENABLE_IN_APP_SERVICES
import Foundation
import UIKit

class ThreadLocalObject<T> {
    private let key: String
    private var valueToBeSetAtGet: T?
    
    init(key: String, initialValue: T) {
        self.key = key
        self.valueToBeSetAtGet = initialValue
    }
    
    var value: T? {
        get {
            if let value = Thread.current.threadDictionary[key] as? T {
                return value
            } else {
                let value = valueToBeSetAtGet
                valueToBeSetAtGet = nil
                Thread.current.threadDictionary[key] = value
                return value
            }
        }
        set {
            Thread.current.threadDictionary[key] = newValue
        }
    }
}

#endif
