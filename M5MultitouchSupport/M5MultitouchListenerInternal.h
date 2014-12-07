//
//  M5MultitouchListenerInternal.h
//  M5MultitouchSupport
//
//  Created by Mathew Huusko V on 12/6/14.
//  Copyright (c) 2014 Mathew Huusko V. All rights reserved.
//

#import "M5MultitouchListener.h"

#import "M5MultitouchEvent.h"

@interface M5MultitouchListener ()

#pragma mark - M5MultitouchListener Internal -

- (instancetype)initWithCallback:(M5MultitouchEventCallback)callback;
- (instancetype)initWithTarget:(id)target selector:(SEL)selector;
- (void)listenToEvent:(M5MultitouchEvent *)event;

- (BOOL)alive;

#pragma mark -

@end
