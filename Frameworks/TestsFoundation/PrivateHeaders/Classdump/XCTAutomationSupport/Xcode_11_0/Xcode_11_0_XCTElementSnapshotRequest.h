#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 130000 && __IPHONE_OS_VERSION_MAX_ALLOWED < 140000

#import "Xcode_11_0_XCTAutomationSupport_CDStructures.h"

#import <Foundation/Foundation.h>

@class XCAXCycleDetector, XCAccessibilityElement, XCElementSnapshot, XCTAccessibilitySnapshot_iOS, XCTTimeoutControls;

//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

@interface XCTElementSnapshotRequest : NSObject
{
    _Bool _loadResult;
    _Bool _hasLoaded;
    XCAccessibilityElement *_element;
    NSArray *_attributes;
    NSDictionary *_parameters;
    XCElementSnapshot *_elementSnapshot;
    id <NSCopying> _accessibilitySnapshot;
    XCTTimeoutControls *_timeoutControls;
    XCAXCycleDetector *_cycleDetector;
    NSObject *_queue;
    NSError *_loadError;
}

@property(retain) NSError *loadError; // @synthesize loadError=_loadError;
@property _Bool hasLoaded; // @synthesize hasLoaded=_hasLoaded;
@property _Bool loadResult; // @synthesize loadResult=_loadResult;
@property(readonly) NSObject *queue; // @synthesize queue=_queue;
@property(retain) XCAXCycleDetector *cycleDetector; // @synthesize cycleDetector=_cycleDetector;
@property(readonly) XCTTimeoutControls *timeoutControls; // @synthesize timeoutControls=_timeoutControls;
@property(copy) id <NSCopying> accessibilitySnapshot; // @synthesize accessibilitySnapshot=_accessibilitySnapshot;
@property(retain) XCElementSnapshot *elementSnapshot; // @synthesize elementSnapshot=_elementSnapshot;
@property(copy) NSDictionary *parameters; // @synthesize parameters=_parameters;
@property(readonly) NSArray *attributes; // @synthesize attributes=_attributes;
@property(readonly) XCAccessibilityElement *element; // @synthesize element=_element;
- (_Bool)loadSnapshotAndReturnError:(id *)arg1;
- (id)initWithElement:(id)arg1 attributes:(id)arg2 parameters:(id)arg3 timeoutControls:(id)arg4;
- (id)initWithElement:(id)arg1 attributes:(id)arg2 parameters:(id)arg3;
- (id)elementSnapshotOrError:(id *)arg1;
- (id)accessibilitySnapshotOrError:(id *)arg1;
- (id)safeParametersForParameters:(id)arg1;
- (id)_snapshotFromUserTestingSnapshot:(id)arg1 frameTransformer:(CDUnknownBlockType)arg2 error:(id *)arg3;
- (id)_childrenOfElement:(id)arg1 userTestingSnapshot:(id)arg2 frameTransformer:(CDUnknownBlockType)arg3 outError:(id *)arg4;
- (id)_snapshotFromRemoteElementUserTestingSnapshot:(id)arg1 parentElement:(id)arg2 error:(id *)arg3;
@property(readonly) XCTAccessibilitySnapshot_iOS *accessibilitySnapshot_iOS;

@end

#endif
