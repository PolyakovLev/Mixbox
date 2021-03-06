#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 130000 && __IPHONE_OS_VERSION_MAX_ALLOWED < 140000

#import "Xcode_11_0_XCTest_CDStructures.h"

#import <Foundation/Foundation.h>

@class XCTestCase;

//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

@interface XCTAttachmentManager : NSObject
{
    _Bool _isValid;
    NSMutableArray *_attachments;
    XCTestCase *_testCase;
}

+ (void)_synthesizeActivityForAttachment:(id)arg1 testCase:(id)arg2;
@property _Bool isValid; // @synthesize isValid=_isValid;
@property(readonly) XCTestCase *testCase; // @synthesize testCase=_testCase;
@property(readonly) NSMutableArray *attachments; // @synthesize attachments=_attachments;
- (void)enqueueAttachment:(id)arg1;
- (void)dequeueAndReportBackgroundAttachments;
- (void)ensureNoRemainingAttachments;
- (void)_invalidate;
- (void)dealloc;
- (id)initWithTestCase:(id)arg1;

@end

#endif
