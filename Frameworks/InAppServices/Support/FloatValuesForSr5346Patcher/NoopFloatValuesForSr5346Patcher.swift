#if MIXBOX_ENABLE_IN_APP_SERVICES
import Foundation
import UIKit

public final class NoopFloatValuesForSr5346Patcher: FloatValuesForSr5346Patcher {
    public init() {
    }
    
    public func patched(float: CGFloat) -> CGFloat {
        return float
    }
}

#endif
