//
//  M5MultitouchManager.m
//  M5MultitouchSupport
//
//  Created by Mathew Huusko V.
//  Copyright (c) 2015 Mathew Huusko V. All rights reserved.
//

#import "M5MultitouchManagerInternal.h"

#import "M5MTDefinesInternal.h"
#import "M5MultitouchListenerInternal.h"
#import "M5MultitouchTouchInternal.h"
#import "M5MultitouchEventInternal.h"
#import <Cocoa/Cocoa.h>

@interface M5MultitouchManager ()

#pragma mark - M5MultitouchManager -

#pragma mark Properties

@property (strong, readwrite) NSMutableArray *multitouchListeners;
@property (strong, readwrite) NSMutableArray *multitouchDevices;
@property (strong, readwrite) NSTimer *hardwareCheckTimer;

#pragma mark -

@end

@implementation M5MultitouchManager

#pragma mark - M5MultitouchManager -

#pragma mark Methods

- (void)removeListener:(M5MultitouchListener *)listener {
    dispatchSync(dispatch_get_main_queue(), ^{
        [self.multitouchListeners removeObject:listener];
        
        if (!self.multitouchListeners.count) {
            [self stopHandlingMultitouchEvents];
        }
    });
}

- (M5MultitouchListener *)addListenerWithCallback:(M5MultitouchEventCallback)callback {
    __block M5MultitouchListener *listener = nil;
    
    dispatchSync(dispatch_get_main_queue(), ^{
        if (!self.class.systemSupportsMultitouch) {
            return;
        }
        
        listener = [[M5MultitouchListener alloc] initWithCallback:callback];
        
        [self.multitouchListeners addObject:listener];
        
        [self startHandlingMultitouchEvents];
    });
    
    return listener;
}

- (M5MultitouchListener *)addListenerWithTarget:(id)target selector:(SEL)selector {
    __block M5MultitouchListener *listener = nil;
    
    dispatchSync(dispatch_get_main_queue(), ^{
        if (!self.class.systemSupportsMultitouch) {
            return;
        }
        
        listener = [[M5MultitouchListener alloc] initWithTarget:target selector:selector];
        
        [self.multitouchListeners addObject:listener];
        
        [self startHandlingMultitouchEvents];
    });
    
    return listener;
}

#pragma mark Properties

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

#pragma mark - M5MultitouchManager (Private) -

#pragma mark Methods

#pragma mark Functions

static void dispatchSync(dispatch_queue_t queue, dispatch_block_t block) {
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Wdeprecated-declarations"
    if (!strcmp(dispatch_queue_get_label(queue), dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL))) {
        block();
        return;
    }
    
    dispatch_sync(queue, block);
    #pragma clang diagnostic pop
}

static void dispatchResponse(dispatch_block_t block) {
    static dispatch_queue_t responseQueue = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        responseQueue = dispatch_queue_create("com.mhuusko5.M5MultitouchSupport", DISPATCH_QUEUE_SERIAL);;
    });
    
    dispatch_sync(responseQueue, block);
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

static BOOL laptopLidClosed = NO;

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
    if (self.multitouchDevices.count && self.multitouchDevices.count != (int)mtDevices.count) {
        [self restartHandlingMultitouchEvents:nil];
    }
}

- (void)handleMultitouchEvent:(M5MultitouchEvent *)event {
    int listenerCount = (int)self.multitouchListeners.count;
    while (--listenerCount >= 0) {
        M5MultitouchListener *listener = self.multitouchListeners[listenerCount];
        
        if (!listener.alive) {
            [self removeListener:listener];
            continue;
        }
        
        if (!listener.listening) {
            continue;
        }
        
        dispatchResponse(^{
            [listener listenToEvent:event];
        });
    }
}

- (void)startHandlingMultitouchEvents {
    if (self.multitouchDevices.count) {
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
        
        [self.multitouchDevices addObject:device];
    }
    
    self.hardwareCheckTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(checkMultitouchHardware) userInfo:nil repeats:YES];
}

- (void)stopHandlingMultitouchEvents {
    if (self.hardwareCheckTimer) {
        [self.hardwareCheckTimer invalidate];
        self.hardwareCheckTimer = nil;
    }
    
    if (!self.multitouchDevices.count) {
        return;
    }
    
    int deviceCount = (int)self.multitouchDevices.count;
    while (--deviceCount >= 0) {
        id device = self.multitouchDevices[deviceCount];
        
        [self.multitouchDevices removeObject:device];
        
        @try {
            MTDeviceRef mtDevice = (__bridge MTDeviceRef)device;
            MTUnregisterContactFrameCallback(mtDevice, mtEventHandler);
            MTDeviceStop(mtDevice);
            MTDeviceRelease(mtDevice);
        } @catch (NSException *exception) {}
    }
}

- (void)restartHandlingMultitouchEvents:(NSNotification *)note {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self stopHandlingMultitouchEvents];
        [self startHandlingMultitouchEvents];
    });
}

#pragma mark -

#pragma mark - NSObject -

#pragma mark Methods

- (instancetype)init {
    if (self = [super init]) {
        self.multitouchListeners = NSMutableArray.new;
        self.multitouchDevices = NSMutableArray.new;
        
        [NSWorkspace.sharedWorkspace.notificationCenter addObserver:self selector:@selector(restartHandlingMultitouchEvents:) name:NSWorkspaceDidWakeNotification object:nil];
    }
    
    return self;
}

#pragma mark -

@end
