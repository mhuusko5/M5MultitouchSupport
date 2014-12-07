//
//  M5MultitouchListener.m
//  M5MultitouchSupport
//
//  Created by Mathew Huusko V on 12/6/14.
//  Copyright (c) 2014 Mathew Huusko V. All rights reserved.
//

#import "M5MultitouchListenerInternal.h"

@implementation M5MultitouchListener {
    @private
    M5MultitouchEventCallback _callback;
    __weak id _target;
    SEL _selector;
    NSThread *_thread;
}

#pragma mark - M5MultitouchListener Internal -

- (instancetype)init {
    if (self = [super init]) {
        _listening = YES;
        _thread = NSThread.currentThread;
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
    
    NSThread *thread = _thread && _thread.isExecuting ? _thread : NSThread.mainThread;
    
    if (![thread isEqual:NSThread.currentThread]) {
        [self performSelector:@selector(listenToEvent:) onThread:thread withObject:event waitUntilDone:NO];
        return;
    }
    
    if (_callback) {
        _callback(event);
        return;
    }
    
    if (_target) {
        [_target performSelector:_selector withObject:event];
        return;
    }
}

- (BOOL)alive {
    return (_callback || (_target && _selector && [_target respondsToSelector:_selector]));
}

#pragma mark -

@end
