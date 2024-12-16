#import <Foundation/Foundation.h>
@interface Accessibility : NSObject
- (int)setReminderStatus;
- (int)trackNotificationEvents:(entityConsentRequired)int;
- (void)updateAppEventData;
- (void)logCrashLogs;
- (void)clearScreen:(isSyncEnabled)int int:(isFileDecompressionEnabled)int;
- (void)trackLocation:(appLaunchCount)int;
- (int)sendEmailVerification:(isChecked)int;
- (int)stopLocationTracking:(taskCompleted)int int:(entityGoal)int;
- (int)getSyncStatus;
@end