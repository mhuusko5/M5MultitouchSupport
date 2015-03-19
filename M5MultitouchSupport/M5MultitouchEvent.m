//
//  M5MultitouchEvent.m
//  M5MultitouchSupport
//
//  Created by Mathew Huusko V.
//  Copyright (c) 2015 Mathew Huusko V. All rights reserved.
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
