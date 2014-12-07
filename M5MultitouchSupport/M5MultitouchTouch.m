//
//  M5MultitouchTouch.m
//  M5MultitouchSupport
//
//  Created by Mathew Huusko V on 12/6/14.
//  Copyright (c) 2014 Mathew Huusko V. All rights reserved.
//

#import "M5MultitouchTouchInternal.h"

@implementation M5MultitouchTouch

#pragma mark - M5MultitouchTouch Internal -

- (id)initWithMTTouch:(MTTouch *)touch {
    if (self = [super init]) {
        _identifier = touch->identifier;
        _state = touch->state;
        _posX = touch->normalizedPosition.position.x;
        _posY = touch->normalizedPosition.position.y;
        _velX = touch->normalizedPosition.velocity.x;
        _velY = touch->normalizedPosition.velocity.y;
        _minorAxis = touch->minorAxis;
        _majorAxis = touch->majorAxis;
        _angle = touch->angle;
        _size = touch->size;
    }
    
    return self;
}

#pragma mark -

#pragma mark - M5MultitouchTouch Private -

- (NSString *)description {
    return [NSString stringWithFormat:@"ID: %i, State: %lu, Position: [%f, %f], Velocity: [%f, %f], Minor Axis: %f, Major Axis: %f, Angle: %f, Size: %f", _identifier, _state, _posX, _posY, _velX, _velY, _minorAxis, _majorAxis, _angle, _size];
}

#pragma mark -

@end