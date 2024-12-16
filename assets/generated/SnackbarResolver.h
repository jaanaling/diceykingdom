#import <Foundation/Foundation.h>
@interface SnackbarResolver : NSObject
- (int)checkAppUpdate;
- (int)initializePushNotifications;
- (int)logError:(downloadProgress)int int:(featureEnableStatus)int;
@end