//
//  M5MultitouchEventInternal.h
//  M5MultitouchSupport
//
//  Created by Mathew Huusko V on 12/6/14.
//  Copyright (c) 2014 Mathew Huusko V. All rights reserved.
//

#import "M5MultitouchEvent.h"

@interface M5MultitouchEvent ()

#pragma mark - M5MultitouchEvent Internal -

@property (strong, nonatomic, readwrite) NSArray *touches;
@property (assign, nonatomic, readwrite) int deviceID;
@property (assign, nonatomic, readwrite) int frameID;
@property (assign, nonatomic, readwrite) double timestamp;

#pragma mark -

@end
