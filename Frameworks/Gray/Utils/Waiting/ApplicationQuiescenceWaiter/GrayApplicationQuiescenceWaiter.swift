import MixboxFoundation
import MixboxTestsFoundation
import MixboxUiTestsFoundation
import MixboxInAppServices
import UIKit
import Foundation

public final class GrayApplicationQuiescenceWaiter: ApplicationQuiescenceWaiter {
    private let waiter: RunLoopSpinningWaiter
    private let idlingResource: IdlingResource
    private let waitingForQuiescenceTimeout: TimeInterval = 15 // TODO: Respect timeout settings of element
    private let waitingForQuiescencePollingInterval: TimeInterval = 0.1
    
    public init(waiter: RunLoopSpinningWaiter, idlingResource: IdlingResource) {
        self.waiter = waiter
        self.idlingResource = idlingResource
    }
    
    public func waitForQuiescence() throws {
        let result = waiter.wait(
            timeout: waitingForQuiescenceTimeout,
            interval: waitingForQuiescencePollingInterval,
            until: { [idlingResource] in
                idlingResource.isIdle()
            }
        )
        
        switch result {
        case .stopConditionMet:
            return
        case .timedOut:
            throw ErrorString("Failed to wait application for quiescence")
        }
    }
}
