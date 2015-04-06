//
//  M5MultitouchTouch.h
//  M5MultitouchSupport
//
//  Created by Mathew Huusko V.
//  Copyright (c) 2015 Mathew Huusko V. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, M5MultitouchTouchState) {
    M5MultitouchTouchStateNotTouching = 0,
    M5MultitouchTouchStateStarting,
    M5MultitouchTouchStateHovering,
    M5MultitouchTouchStateMaking,
    M5MultitouchTouchStateTouching,
    M5MultitouchTouchStateBreaking,
    M5MultitouchTouchStateLingering,
    M5MultitouchTouchStateLeaving
};

@interface M5MultitouchTouch : NSObject

#pragma mark - M5MultitouchTouch -

#pragma mark Properties

/** Identifier of touch, persistent/applicable across events. */
@property (assign, nonatomic, readonly) int identifier;

/** Current state of touch. 0 is not touching, anything else is some kind of touching. */
@property (assign, nonatomic, readonly) M5MultitouchTouchState state;

/** Coordinates of touch (each value 0 -> 1, so basically percent of touch surface). */
@property (assign, nonatomic, readonly) float posX, posY;
 
/** Coordinates of touch (each value 0 -> 1, so basically percent of touch surface). */
@property (assign, nonatomic, readonly) float velX, velY;

/** Minor and major axis of touch. */
@property (assign, nonatomic, readonly) float minorAxis, majorAxis;

/** Angle of touch (angle of finger tip from north). */
@property (assign, nonatomic, readonly) float angle;

/** Size of touch (finger tip surface area touching). */
@property (assign, nonatomic, readonly) float size;

#pragma makr -

@end
