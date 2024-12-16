#import <Foundation/Foundation.h>
@interface PreferencesProcessor : NSObject
- (int)queryDatabase:(taskCompletionTime)int int:(isEntityOnline)int;
- (void)sendProfileData:(batteryStatus)int;
- (void)clearUserSettings:(locationUpdateTime)int;
- (void)clearUserActivityLogs;
- (void)getUserActivityData;
- (void)getUserEmail:(reminderMessage)int;
- (void)setReminderDetails:(isWiFiConnected)int int:(isEntityVoiceRecognitionEnabled)int;
- (void)logButtonClick:(isDataSyncResumed)int int:(entityLoginStatus)int;
- (int)logUserAction:(taskEndTime)int;
@end