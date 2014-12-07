//
//  M5MultitouchManager.m
//  M5MultitouchSupport
//
//  Created by Mathew Huusko V on 12/6/14.
//  Copyright (c) 2014 Mathew Huusko V. All rights reserved.
//

#import "M5MultitouchManagerInternal.h"

#import <Cocoa/Cocoa.h>
#import "M5MTDefinesInternal.h"
#import "M5MultitouchListenerInternal.h"
#import "M5MultitouchTouchInternal.h"
#import "M5MultitouchEventInternal.h"

@implementation M5MultitouchManager {
    @private
    NSMutableArray *_multitouchListeners, *_multitouchDevices;
    NSTimer *_multitouchHardwareCheckTimer;
}

#pragma mark - M5MultitouchManager -

- (void)removeListener:(M5MultitouchListener *)listener {
    [_multitouchListeners removeObject:listener];
    
    if (!_multitouchListeners.count) {
        [self stopHandlingMultitouchEvents];
    }
}

- (M5MultitouchListener *)addListenerWithCallback:(M5MultitouchEventCallback)callback {
    if (![self.class systemSupportsMultitouch]) {
        return nil;
    }
    
    M5MultitouchListener *listener = [[M5MultitouchListener alloc] initWithCallback:callback];
    
    [_multitouchListeners addObject:listener];
    
    [self startHandlingMultitouchEvents];
    
    return listener;
}

- (M5MultitouchListener *)addListenerWithTarget:(id)target selector:(SEL)selector {
    if (![self.class systemSupportsMultitouch]) {
        return nil;
    }
    
    M5MultitouchListener *listener = [[M5MultitouchListener alloc] initWithTarget:target selector:selector];
    
    [_multitouchListeners addObject:listener];
    
    [self startHandlingMultitouchEvents];
    
    return listener;
}

+ (BOOL)systemSupportsMultitouch {
    return MTDeviceIsAvailable();
}

+ (M5MultitouchManager *)sharedManager {
    static M5MultitouchManager *sharedManager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = self.new;
    });
    
    return sharedManager;
}

#pragma mark -

#pragma mark - M5MultitouchManager Private -

- (instancetype)init {
    if (self = [super init]) {
        _multitouchListeners = NSMutableArray.new;
        _multitouchDevices = NSMutableArray.new;
        
		[NSWorkspace.sharedWorkspace.notificationCenter addObserver:self selector:@selector(restartHandlingMultitouchEvents:) name:NSWorkspaceDidWakeNotification object:nil];
    }
    
    return self;
}

static void mtEventHandler(MTDeviceRef mtEventDevice, MTTouch mtEventTouches[], int mtEventTouchesNum, double mtEventTimestamp, int mtEventFrameId) {
    if (MTDeviceIsBuiltIn && MTDeviceIsBuiltIn(mtEventDevice) && laptopLidClosed) {
        return;
    }
    
    NSMutableArray *multitouchTouches = [[NSMutableArray alloc] initWithCapacity:mtEventTouchesNum];
    for (int i = 0; i < mtEventTouchesNum; i++) {
        M5MultitouchTouch *multitouchTouch = [[M5MultitouchTouch alloc] initWithMTTouch:&mtEventTouches[i]];
        multitouchTouches[i] = multitouchTouch;
    }
    
    M5MultitouchEvent *multitouchEvent = M5MultitouchEvent.new;
    multitouchEvent.touches = multitouchTouches;
    multitouchEvent.deviceID = (int)mtEventDevice;
    multitouchEvent.frameID = mtEventFrameId;
    multitouchEvent.timestamp = mtEventTimestamp;
    
    [M5MultitouchManager.sharedManager handleMultitouchEvent:multitouchEvent];
}

static BOOL laptopLidClosed;

- (void)checkMultitouchHardware {
    CGDirectDisplayID builtInDisplay = 0;
    CGDirectDisplayID activeDisplays[10];
    uint32_t numActiveDisplays;
    CGGetActiveDisplayList(10, activeDisplays, &numActiveDisplays);
    
    int activeDisplayCount = (int)numActiveDisplays;
    while (--activeDisplayCount >= 0) {
        if (CGDisplayIsBuiltin(activeDisplays[activeDisplayCount])) {
            builtInDisplay = activeDisplays[activeDisplayCount];
            break;
        }
    }
    laptopLidClosed = (builtInDisplay == 0);
    
    NSArray *mtDevices = (NSArray *)CFBridgingRelease(MTDeviceCreateList());
    if (_multitouchDevices.count && _multitouchDevices.count != (int)mtDevices.count) {
        [self restartHandlingMultitouchEvents:nil];
    }
}

- (void)handleMultitouchEvent:(M5MultitouchEvent *)event {
    int listenerCount = (int)_multitouchListeners.count;
    while (--listenerCount >= 0) {
        M5MultitouchListener *listener = _multitouchListeners[listenerCount];
        
        if (!listener.alive) {
            [self removeListener:listener];
            continue;
        }
        
        if (!listener.listening) {
            continue;
        }
        
        [listener listenToEvent:event];
    }
}

- (void)startHandlingMultitouchEvents {
    if (_multitouchDevices.count) {
        return;
    }
    
    NSArray *mtDevices = (NSArray *)CFBridgingRelease(MTDeviceCreateList());
    
    int mtDeviceCount = (int)mtDevices.count;
    while (--mtDeviceCount >= 0) {
        id device = mtDevices[mtDeviceCount];
        
        @try {
            MTDeviceRef mtDevice = (__bridge MTDeviceRef)device;
            MTRegisterContactFrameCallback(mtDevice, mtEventHandler);
            MTDeviceStart(mtDevice, 0);
        } @catch (NSException *exception) {}
        
        [_multitouchDevices addObject:device];
    }
    
    _multitouchHardwareCheckTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(checkMultitouchHardware) userInfo:nil repeats:YES];
}

- (void)stopHandlingMultitouchEvents {
    if (_multitouchHardwareCheckTimer) {
        [_multitouchHardwareCheckTimer invalidate];
        _multitouchHardwareCheckTimer = nil;
    }
    
    if (!_multitouchDevices.count) {
        return;
    }
    
    int deviceCount = (int)_multitouchDevices.count;
    while (--deviceCount >= 0) {
        id device = _multitouchDevices[deviceCount];
        
        [_multitouchDevices removeObject:device];
        
        @try {
            MTDeviceRef mtDevice = (__bridge MTDeviceRef)device;
            MTUnregisterContactFrameCallback(mtDevice, mtEventHandler);
            MTDeviceStop(mtDevice);
            MTDeviceRelease(mtDevice);
        } @catch (NSException *exception) {}
    }
}

- (void)restartHandlingMultitouchEvents:(NSNotification *)note {
    [self stopHandlingMultitouchEvents];
    [self startHandlingMultitouchEvents];
}

#pragma mark -

@end
