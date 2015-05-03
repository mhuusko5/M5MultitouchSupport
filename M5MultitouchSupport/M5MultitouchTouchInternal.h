//
//  M5MultitouchTouchInternal.h
//  M5MultitouchSupport
//

#import "M5MultitouchTouch.h"

#import "M5MTDefinesInternal.h"

@interface M5MultitouchTouch ()

#pragma mark - M5MultitouchTouch (Internal) -

#pragma mark Methods

- (id)initWithMTTouch:(MTTouch *)touch;

#pragma mark Properties

@property (assign, readwrite) int identifier;
@property (assign, readwrite) M5MultitouchTouchState state;
@property (assign, readwrite) float posX, posY;
@property (assign, readwrite) float velX, velY;
@property (assign, readwrite) float minorAxis, majorAxis;
@property (assign, readwrite) float angle;
@property (assign, readwrite) float size;

#pragma mark -

@end
