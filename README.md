# M5MultitouchSupport

Easily and (thread/memory) safely consume global OS X multitouch (trackpad, Magic Mouse) events.

## Installation

### From CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Objective-C, which automates and simplifies the process of using 3rd-party libraries like `M5MultitouchSupport` in your projects. Simply add the following line to your [Podfile](http://guides.cocoapods.org/using/using-cocoapods.html):

```ruby
pod 'M5MultitouchSupport'
```

If you want to use the latest features of `M5MultitouchSupport` add `:head`:

```ruby
pod 'M5MultitouchSupport', :head
```

This pulls from the `master` branch directly, which is almost always usually stable.

### Manually

Note: Requires ARC, and Mac OS 10.8+

#### Using Framework

* Open the `M5MultitouchSupport/M5MultitouchSupport.xcodeproj` project, and build the default target.
* Add the resulting `Products/M5MultitouchSupport.framework` to your project.
* Add **/System/Library/PrivateFrameworks/MultitouchSupport.framework** to your project.

#### Using Source Files

* Drag the `M5MultitouchSupport/M5MultitouchSupport` folder into your project.
* Add **/System/Library/PrivateFrameworks/MultitouchSupport.framework** to your project.

## Usage

Using `M5MultitouchSupport` in your app or framework is as simple as...

```objective-c
#import <M5MultitouchSupport.h>
```
### Using Blocks

```objective-c
[M5MultitouchManager.sharedManager addListenerWithCallback:^(M5MultitouchEvent *event) {
  NSLog(event.description);
  
  /*
  Touches: (
    "ID: 3, State: 4 (Touching), Position: [0.251363, 0.475246], Velocity: [0.009912, -0.003619], Minor Axis: 8.160000, Major Axis: 9.920000, Angle: 1.911052, Size: 0.750000",
    "ID: 6, State: 4 (Touching), Position: [0.618595, 0.839751], Velocity: [-0.007434, -0.014476], Minor Axis: 8.230000, Major Axis: 9.220000, Angle: 1.570796, Size: 0.625000",
    "ID: 8, State: 4 (Touching), Position: [0.410051, 0.792415], Velocity: [0.008673, 0.018095], Minor Axis: 7.660000, Major Axis: 8.890000, Angle: 1.570796, Size: 0.628906"
  ), Device ID: 25381376, Frame ID: 1435, Timestamp: 3827.383000
  */
}];
```

Note: Multitouch event processing happens on a separate thread, but your listener will be passed events on the thread it was created (or the main thread if the original thread ever stops).

### Using Targets/Selectors

```objective-c
[M5MultitouchManager.sharedManager addListenerWithTarget:self 
                                                selector:@selector(handleMultitouchEvent:)];
```

```objective-c
- (void)handleMultitouchEvent:(M5MultitouchEvent *)event {
    NSLog(event.description);
}
```

Note: Only a weak reference is held to the target, and `M5MultitouchManager` will safely remove the listener if that reference zeroes out.

### Managing Listeners

```objective-c
M5MultitouchListener *listener = [M5MultitouchManager.sharedManager addListenerWith...

listener.listening = NO; 
//Listener will stop receiving events until set to YES

[M5MultitouchManager.sharedManager removeListener:listener]; 
//Will stop/remove the listener altogether
```

## Contributing to this project

If you have feature requests or bug reports, feel free to help out by sending pull requests or by [creating new issues](https://github.com/mhuusko5/M5MultitouchSupport/issues/new).

## Credits

`M5MultitouchSupport` is brought to you by [Mathew Huusko V](http://mhuusko5.com) and [contributors to the project](https://github.com/mhuusko5/M5MultitouchSupport/contributors). If you're using `M5MultitouchSupport` in your project, attribution would be very appreciated.
