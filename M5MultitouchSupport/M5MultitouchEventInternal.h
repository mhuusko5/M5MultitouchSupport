//
//  M5MultitouchEventInternal.h
//  M5MultitouchSupport
//
//  Created by Mathew Huusko V.
//  Copyright (c) 2015 Mathew Huusko V. All rights reserved.
//

#import "M5MultitouchEvent.h"

@interface M5MultitouchEvent ()

#pragma mark - M5MultitouchEvent (Internal) -

#pragma mark Properties

@property (strong, nonatomic, readwrite) NSArray *touches;
@property (assign, nonatomic, readwrite) int deviceID;
@property (assign, nonatomic, readwrite) int frameID;
@property (assign, nonatomic, readwrite) double timestamp;

#pragma mark -

@end
