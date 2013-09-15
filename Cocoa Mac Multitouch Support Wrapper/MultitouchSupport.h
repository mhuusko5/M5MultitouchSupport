typedef struct {
	float x;
	float y;
} MTPoint;

typedef struct {
	MTPoint position;
	MTPoint velocity;
} MTVector;

typedef struct {
    int frame; // the current frame
    double timestamp; // event timestamp
	int identifier; // identifier guaranteed unique for life of touch per device
	int state; //the current state (not sure what the values mean)
	int unknown1; 
	int unknown2;
	MTVector normalized; //the normalized position and vector of the touch (0,0 to 1,1)
	float size; //the size of the touch (the area of your finger being tracked)
	int unknown3;
	float angle; //the angle of the touch            -|
	float majorAxis; //the major axis of the touch   -|-- an ellipsoid. you can track the angle of each finger!
	float minorAxis; //the minor axis of the touch   -|
	MTVector unknown4;
	int unknown5[2];
	float unknown6;
} MTTouch;

typedef void *MTDeviceRef; //a reference pointer for the multitouch device
typedef int (*MTContactCallbackFunction)(int, MTTouch*, int, double, int); //the prototype for the callback function

MTDeviceRef MTDeviceCreateDefault(); //returns a pointer to the default device (the trackpad)
CFMutableArrayRef MTDeviceCreateList(void); //returns a CFMutableArrayRef array of all multitouch devices
void* MTRegisterContactFrameCallback(MTDeviceRef, MTContactCallbackFunction); //registers a device's frame callback to your callback function
void MTDeviceStart(MTDeviceRef, int); //start sending events
