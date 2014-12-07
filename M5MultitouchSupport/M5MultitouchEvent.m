//
//  M5MultitouchEvent.m
//  M5MultitouchSupport
//
//  Created by Mathew Huusko V on 12/6/14.
//  Copyright (c) 2014 Mathew Huusko V. All rights reserved.
//

#import "M5MultitouchEventInternal.h"

@implementation M5MultitouchEvent

#pragma mark - M5MultitouchEvent Private -

- (NSString *)description {
    return [NSString stringWithFormat:@"Touches: %@, Device ID: %i, Frame ID: %i, Timestamp: %f", _touches.description, _deviceID, _frameID, _timestamp];
}

#pragma mark -

@end
