//
//  M5MultitouchEvent.h
//  M5MultitouchSupport
//

#import <Foundation/Foundation.h>

@interface M5MultitouchEvent : NSObject

#pragma mark - M5MultitouchEvent -

#pragma mark Properties

/** Array of M5MultitouchTouches associated with event. */
@property (strong, readonly) NSArray *touches;

/** Identifier of multitouch device (trackpad, Magic Mouse, etc.). Unique only per process. */
@property (assign, readonly) int deviceID;

/** Identifier of frame (essentially unique identifier of event). Starts at 0, increments. */
@property (assign, readonly) int frameID;

/** Time event was created. */
@property (assign, readonly) double timestamp;

#pragma mark -

@end

typedef void (^M5MultitouchEventCallback)(M5MultitouchEvent *event);