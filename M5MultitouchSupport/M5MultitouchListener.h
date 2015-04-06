//
//  M5MultitouchListener.h
//  M5MultitouchSupport
//
//  Created by Mathew Huusko V.
//  Copyright (c) 2015 Mathew Huusko V. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface M5MultitouchListener : NSObject

#pragma mark - M5MultitouchListener -

#pragma mark Properties

/** Whether listener should receive multitouch events. */
@property (assign, readwrite) BOOL listening;

#pragma mark -

@end
