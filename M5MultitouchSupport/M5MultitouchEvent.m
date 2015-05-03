//
//  M5MultitouchEvent.m
//  M5MultitouchSupport
//

#import "M5MultitouchEventInternal.h"

@implementation M5MultitouchEvent

#pragma mark - NSObject -

#pragma mark Properties

- (NSString *)description {
    return [NSString stringWithFormat:@"Touches: %@, Device ID: %i, Frame ID: %i, Timestamp: %f", _touches.description, _deviceID, _frameID, _timestamp];
}

#pragma mark -

@end
