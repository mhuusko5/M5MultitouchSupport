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

@property (strong, nonatomic, readonly) NSArray *touches;
@property (assign, nonatomic, readonly) int deviceID;
@property (assign, nonatomic, readonly) int frameID;
@property (assign, nonatomic, readonly) double timestamp;

#pragma mark -

@end

typedef void (^M5MultitouchEventCallback)(M5MultitouchEvent *event);