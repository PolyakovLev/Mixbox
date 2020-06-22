#ifdef MIXBOX_ENABLE_IN_APP_SERVICES

#ifndef EnumRawValues_h
#define EnumRawValues_h

#if SWIFT_PACKAGE
#include "../PrivateApi/IOKit/hid/IOHIDEventTypes.h"
#else
#include "IOHIDEventTypes.h"
#endif


__BEGIN_DECLS

// Added to support initializing enum with rawValue (enums have only failable initializer, even if they are open).

IOHIDDigitizerTransducerType IOHIDDigitizerTransducerTypeFromRawValue(uint32_t rawValue);
IOHIDEventType IOHIDEventTypeFromRawValue(uint32_t rawValue);

__END_DECLS

#endif /* EnumRawValues_h */
#endif
