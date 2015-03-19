//
//  M5MultitouchListener.m
//  M5MultitouchSupport
//
//  Created by Mathew Huusko V.
//  Copyright (c) 2015 Mathew Huusko V. All rights reserved.
//

#import "M5MultitouchListenerInternal.h"

@implementation M5MultitouchListener {
    @private
    M5MultitouchEventCallback _callback;
    __weak id _target;
    SEL _selector;
}

#pragma mark - M5MultitouchListener (Internal) -

#pragma mark Methods

- (instancetype)init {
    if (self = [super init]) {
        _listening = YES;
    }
    
    return self;
}

- (instancetype)initWithCallback:(M5MultitouchEventCallback)callback {
    if (self = [self init]) {
        _callback = callback;
    }
    
    return self;
}

- (instancetype)initWithTarget:(id)target selector:(SEL)selector {
    if (self = [self init]) {
        _target = target;
        _selector = selector;
    }
    
    return self;
}

- (void)listenToEvent:(M5MultitouchEvent *)event {
    if (!self.alive || !self.listening) {
        return;
    }
    
    if (_callback) {
        _callback(event);
        return;
    }
    
    if (_target) {
        ((void(*)(id, SEL, M5MultitouchEvent*))[_target methodForSelector:_selector])(_target, _selector, event);
        return;
    }
}

#pragma mark Properties

- (BOOL)alive {
    return (_callback || (_target && _selector && [_target respondsToSelector:_selector]));
}

#pragma mark -

@end
