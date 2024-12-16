#import <Foundation/Foundation.h>
@interface DebuggerAggregator : NSObject
- (void)updateUserStatus:(isDeviceInLandscapeMode)int int:(isAppUpdateNotified)int;
- (int)trackAppProgress;
@end