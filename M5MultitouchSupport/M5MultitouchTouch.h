//
//  M5MultitouchTouch.h
//  M5MultitouchSupport
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
@property (assign, readonly) int identifier;

/** Current state of touch. 0 is not touching, anything else is some kind of touching. */
@property (assign, readonly) M5MultitouchTouchState state;

/** Coordinates of touch (each value 0 -> 1, so basically percent of touch surface). */
@property (assign, readonly) float posX, posY;
 
/** Coordinates of touch (each value 0 -> 1, so basically percent of touch surface). */
@property (assign, readonly) float velX, velY;

/** Minor and major axis of touch. */
@property (assign, readonly) float minorAxis, majorAxis;

/** Angle of touch (angle of finger tip from north). */
@property (assign, readonly) float angle;

/** Size of touch (finger tip surface area touching). */
@property (assign, readonly) float size;

#pragma makr -

@end
