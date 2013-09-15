#import "MultitouchManager.h"

@implementation MultitouchManager

- (void)handleMultitouchEvent:(MultitouchEvent *)event
{
    if ([[NSThread currentThread] isMainThread]) {
        if (forwardingMultitouchEventsToListeners) {
            for (MultitouchListener *multitouchListenerToForwardEvent in multitouchListeners) {
                [multitouchListenerToForwardEvent sendMultitouchEvent:event];
            }
        }
    } else {
        [self performSelectorOnMainThread:@selector(handleMultitouchEvent) withObject:event waitUntilDone:NO];
    }
}

- (void)startForwardingMultitouchEventsToListeners
{
    if ([[NSThread currentThread] isMainThread]) {
        NSArray *mtDevices = (NSArray *)CFBridgingRelease(MTDeviceCreateList());
        for (id device in mtDevices) {
            MTDeviceRef mtDevice = (__bridge MTDeviceRef)device;
            MTRegisterContactFrameCallback(mtDevice, mtEventHandler);
            MTDeviceStart(mtDevice, 0);
        }
        
        forwardingMultitouchEventsToListeners = YES;
    } else {
        [self performSelectorOnMainThread:@selector(startForwardingMultitouchEventsToListeners) withObject:nil waitUntilDone:NO];
    }
}

//TODO: Should probably be called before sleeping of laptop, and then the above on wake
- (void)stopForwardingMultitouchEventsToListeners
{
    if ([[NSThread currentThread] isMainThread]) {
        //TODO: Unregister multitouch devices
        
        forwardingMultitouchEventsToListeners = NO;
    } else {
        [self performSelectorOnMainThread:@selector(stopForwardingMultitouchEventsToListeners) withObject:nil waitUntilDone:NO];
    }
}

- (void)removeMultitouchListersWithTarget:(id)target andCallback:(SEL)callback
{
    if (!multitouchListeners || multitouchListeners.count < 1) {
        return;
    }
    
    for (MultitouchListener *multitouchListerToRemove in multitouchListeners) {
        if ([multitouchListerToRemove.target isEqual:target] && (!callback || multitouchListerToRemove.callback == callback)) {
            [multitouchListeners removeObject:multitouchListerToRemove];
        }
    }
}

- (void)addMultitouchListenerWithTarget:(id)target callback:(SEL)callback andThread:(NSThread *)thread
{
    if (!multitouchListeners) {
        multitouchListeners = [NSMutableArray array];
    }
    
    [multitouchListeners addObject:[[MultitouchListener alloc] initWithTarget:target callback:callback andThread:thread]];
    
    if (!forwardingMultitouchEventsToListeners) {
        [self startForwardingMultitouchEventsToListeners];
    }
}

static int mtEventHandler(int mtEventDeviceId, MTTouch* mtEventTouches, int mtEventTouchesNum, double mtEventTimestamp, int mtEventFrameId)
{
    MultitouchEvent *multitouchEvent = [[MultitouchEvent alloc] initWithDeviceIdentifier:mtEventDeviceId frameIdentifier:mtEventDeviceId andTimestamp:mtEventTimestamp];
    
    NSMutableArray *multitouchTouches = [[NSMutableArray alloc] initWithCapacity:mtEventTouchesNum];
    for (int i = 0; i < mtEventTouchesNum; i++) {
        MultitouchTouch *multitouchTouch = [[MultitouchTouch alloc] initWithMTTouch:&mtEventTouches[i] andMultitouchEvent:multitouchEvent];
        [multitouchTouches addObject:multitouchTouch];
    }
    
    [multitouchEvent setTouches:[NSArray arrayWithArray:multitouchTouches]];
    
    [[MultitouchManager sharedMultitouchManager] handleMultitouchEvent:multitouchEvent];
    
    return 0;
}

static MultitouchManager *sharedMultitouchManager = nil;
static BOOL sharedMultitouchManagerInitialized = NO;

- (id)init
{
    if (!sharedMultitouchManagerInitialized) {
        sharedMultitouchManagerInitialized = YES;
        return self = [super init];
    } else {
        return nil;
    }
}

+ (void)initialize {
    if (!sharedMultitouchManager && self == [MultitouchManager class]) {
        sharedMultitouchManager = [[self alloc] init];
    }
}

+ (MultitouchManager *)sharedMultitouchManager {
    return sharedMultitouchManager;
}

@end

