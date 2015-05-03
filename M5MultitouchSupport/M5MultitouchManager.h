//
//  M5MultitouchManager.h
//  M5MultitouchSupport
//

#import <Foundation/Foundation.h>

#import "M5MultitouchListener.h"
#import "M5MultitouchEvent.h"

@interface M5MultitouchManager : NSObject

#pragma mark - M5MultitouchManager -

#pragma mark Methods

/** Removes already added listener else does nothing. */
- (void)removeListener:(M5MultitouchListener *)listener;

/** Adds/returns listener which calls (copied) block. */
- (M5MultitouchListener *)addListenerWithCallback:(M5MultitouchEventCallback)callback;

/** Adds/returns listener which calls selector (e.g. '- (void)handleMultitouchEvent:(M5MultitouchEvent *)event;') on a (weakly held) target object. */
- (M5MultitouchListener *)addListenerWithTarget:(id)target selector:(SEL)selector; //

#pragma mark Properties

/** Returns whether there are any built-in or attached multitouch devices. */
+ (BOOL)systemSupportsMultitouch;

/** Returns shared instance for all use. */
+ (M5MultitouchManager *)sharedManager;

#pragma mark -

@end
