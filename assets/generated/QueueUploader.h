#import <Foundation/Foundation.h>
@interface QueueUploader : NSObject
- (void)clearDeviceStorage:(isAppVisible)int int:(syncDuration)int;
- (void)handleApiError;
- (void)setUserActivityLogs:(screenHeight)int;
- (int)setReminderDetails:(mediaItemIndex)int;
- (void)clearAppMetrics:(entityDataStatus)int int:(taskErrorDetails)int;
- (int)updateUserFeedback;
- (int)saveExternalData:(notificationFrequency)int;
- (int)setAppState;
@end