//
//  M5MultitouchManager.h
//  M5MultitouchSupport
//
//  Created by Mathew Huusko V.
//  Copyright (c) 2015 Mathew Huusko V. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "M5MultitouchListener.h"
#import "M5MultitouchEvent.h"

@interface M5MultitouchManager : NSObject

#pragma mark - M5MultitouchManager -

#pragma mark Methods

- (void)removeListener:(M5MultitouchListener *)listener;
- (M5MultitouchListener *)addListenerWithCallback:(M5MultitouchEventCallback)callback;
- (M5MultitouchListener *)addListenerWithTarget:(id)target selector:(SEL)selector; //e.g. @selector(handleMultitouchEvent:)

#pragma mark Properties

+ (BOOL)systemSupportsMultitouch;
+ (M5MultitouchManager *)sharedManager;

#pragma mark -

@end
