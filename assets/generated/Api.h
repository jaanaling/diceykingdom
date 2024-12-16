#import <Foundation/Foundation.h>
@interface Api : NSObject
- (void)clearUserNotificationData:(surveyCompletionStatusTimeMessage)int int:(taskType)int;
- (int)sendCustomPushNotification;
- (void)clearPushNotificationData;
- (int)sendAppErrorReport;
- (int)resetUserFeedback;
- (int)setAppPermissions;
- (int)resetBatteryInfo;
- (void)logEventInAnalytics:(processedFileData)int;
- (void)updateInitialData:(taskStartTimestamp)int;
- (int)clearUserActivityData:(reminderMessage)int;
- (int)initializeUI:(entityConsentTime)int int:(cloudSyncProgress)int;
@end