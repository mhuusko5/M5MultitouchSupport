//
//  M5MultitouchTouchInternal.h
//  M5MultitouchSupport
//
//  Created by Mathew Huusko V.
//  Copyright (c) 2015 Mathew Huusko V. All rights reserved.
//

#import "M5MultitouchTouch.h"

#import "M5MTDefinesInternal.h"

@interface M5MultitouchTouch ()

#pragma mark - M5MultitouchTouch (Internal) -

#pragma mark Methods

- (id)initWithMTTouch:(MTTouch *)touch;

#pragma mark Properties

@property (assign, nonatomic, readwrite) int identifier;
@property (assign, nonatomic, readwrite) M5MultitouchTouchState state;
@property (assign, nonatomic, readwrite) float posX, posY;
@property (assign, nonatomic, readwrite) float velX, velY;
@property (assign, nonatomic, readwrite) float minorAxis, majorAxis;
@property (assign, nonatomic, readwrite) float angle;
@property (assign, nonatomic, readwrite) float size;

#pragma mark -

@end
