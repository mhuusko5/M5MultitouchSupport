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

@property (assign, nonatomic, readonly) int identifier;
@property (assign, nonatomic, readonly) M5MultitouchTouchState state;
@property (assign, nonatomic, readonly) float posX, posY;
@property (assign, nonatomic, readonly) float velX, velY;
@property (assign, nonatomic, readonly) float minorAxis, majorAxis;
@property (assign, nonatomic, readonly) float angle;
@property (assign, nonatomic, readonly) float size;

#pragma makr -

@end
