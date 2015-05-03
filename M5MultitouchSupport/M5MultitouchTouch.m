//
//  M5MultitouchTouch.m
//  M5MultitouchSupport
//

#import "M5MultitouchTouchInternal.h"

@implementation M5MultitouchTouch

#pragma mark - M5MultitouchTouch (Internal) -

#pragma mark Methods

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

#pragma mark - NSObject -

#pragma mark Properties

- (NSString *)description {
    return [NSString stringWithFormat:@"ID: %i, State: %lu, Position: [%f, %f], Velocity: [%f, %f], Minor Axis: %f, Major Axis: %f, Angle: %f, Size: %f", _identifier, _state, _posX, _posY, _velX, _velY, _minorAxis, _majorAxis, _angle, _size];
}

#pragma mark -

@end
