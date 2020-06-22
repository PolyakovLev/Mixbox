#if MIXBOX_ENABLE_IN_APP_SERVICES
import Foundation
import MixboxFoundation_objc

public final class ObjectiveCExceptionCatcher {
    public static func `catch`<T>(
        try: () -> (T),
        catch: (NSException) -> (T),
        finally: () -> () = {})
        -> T
    {
        var result: T?
        
        ObjectiveCExceptionCatcherHelper_try(
            {
                result = `try`()
            },
            { e in
                result = `catch`(e)
            },
            finally
        )
        
        // swiftlint:disable:next force_unwrapping
        return result!
    }
    
    private init() {
    }
}

#endif
