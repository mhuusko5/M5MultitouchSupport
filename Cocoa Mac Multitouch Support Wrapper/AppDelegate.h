#import <Cocoa/Cocoa.h>
#import "MultitouchManager.h"

@interface AppDelegate : NSObject <NSApplicationDelegate>

- (void)doSomethingWithMultitouchEvent:(MultitouchEvent *)event;

@end
