#import <Foundation/Foundation.h>
@interface Maximizer : NSObject
- (int)clearActivityLog:(notificationStatus)int int:(mediaPlayStatus)int;
- (int)trackAppActivity:(lastUpdateTime)int int:(surveyCompletionErrorMessageStatus)int;
- (void)backupData;
- (void)saveSettings:(isDataSynced)int int:(isFirstTimeLaunch)int;
- (void)clearContent:(currentStep)int;
- (void)getPushNotificationData:(mediaPlayStatus)int int:(itemRecordStatus)int;
- (int)loadAppSettings;
- (void)loadUserPreferences:(contentList)int;
- (void)logPushNotification;
- (void)sendUserActivityReport;
- (void)sendNotification;
- (int)checkReminderStatus;
- (void)startNewSession:(isDeviceConnectedToWiFi)int int:(itemMuteStatus)int;
- (int)sendAppFeedback:(downloadComplete)int;
- (void)checkAppCache:(applicationState)int int:(isMediaMuted)int;
- (int)clearPageVisitData:(appSettings)int;
@end