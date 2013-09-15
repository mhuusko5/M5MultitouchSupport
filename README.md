Cocoa Mac Multitouch Support Wrapper
====================================

Wrapper for the MultitouchSupport.framework private Cocoa framework under Mac OS X. Drop-in solution to easily receive and respond to system-wide multitouch events in a Cocoa application.

Listening to system wide multitouch events from all devices, in a Obj-C manner is now as easy as:

#import "MultitouchManager.h"
 
[[MultitouchManager sharedMultitouchManager] addMultitouchListenerWithTarget:self callback:@selector(doSomethingWithMultitouchEvent:) andThread:nil];
