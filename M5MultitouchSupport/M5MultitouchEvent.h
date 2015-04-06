//
//  M5MultitouchEvent.h
//  M5MultitouchSupport
//
//  Created by Mathew Huusko V.
//  Copyright (c) 2015 Mathew Huusko V. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface M5MultitouchEvent : NSObject

#pragma mark - M5MultitouchEvent -

#pragma mark Properties

/** Array of M5MultitouchTouches associated with event. */
@property (strong, nonatomic, readonly) NSArray *touches;

/** Identifier of multitouch device (trackpad, Magic Mouse, etc.). Unique only per process. */
@property (assign, nonatomic, readonly) int deviceID;

/** Identifier of frame (essentially unique identifier of event). Starts at 0, increments. */
@property (assign, nonatomic, readonly) int frameID;

/** Time event was created. */
@property (assign, nonatomic, readonly) double timestamp;

#pragma mark -

@end

typedef void (^M5MultitouchEventCallback)(M5MultitouchEvent *event);