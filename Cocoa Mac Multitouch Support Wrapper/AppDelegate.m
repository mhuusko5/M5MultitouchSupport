#import "AppDelegate.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	[[MultitouchManager sharedMultitouchManager] addMultitouchListenerWithTarget:self callback:@selector(doSomethingWithMultitouchEvent:) andThread:nil];
}

- (void)doSomethingWithMultitouchEvent:(MultitouchEvent *)event {
	NSLog(@"%@", [event description]);
}

@end
