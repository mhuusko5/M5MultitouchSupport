//
//  M5MultitouchTouchInternal.h
//  M5MultitouchSupport
//
//  Created by Mathew Huusko V on 12/6/14.
//  Copyright (c) 2014 Mathew Huusko V. All rights reserved.
//

#import "M5MultitouchTouch.h"

#import "M5MTDefinesInternal.h"

@interface M5MultitouchTouch ()

#pragma mark - M5MultitouchTouch Internal -

@property (assign, nonatomic, readwrite) int identifier;
@property (assign, nonatomic, readwrite) M5MultitouchTouchState state;
@property (assign, nonatomic, readwrite) float posX, posY;
@property (assign, nonatomic, readwrite) float velX, velY;
@property (assign, nonatomic, readwrite) float minorAxis, majorAxis;
@property (assign, nonatomic, readwrite) float angle;
@property (assign, nonatomic, readwrite) float size;

- (id)initWithMTTouch:(MTTouch *)touch;

#pragma mark -

@end
