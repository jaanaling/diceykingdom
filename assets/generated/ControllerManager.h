#import <Foundation/Foundation.h>
@interface ControllerManager : NSObject
- (int)clearAppFeedback;
- (void)getUserDetails:(appUpdateStatus)int;
- (void)sendActivityDetails:(isRecording)int int:(permissionStatus)int;
- (void)trackAppMetrics:(taskFailureReason)int int:(loginErrorMessage)int;
- (void)downloadUpdate;
- (void)setUserActivityLogs:(surveyAnswerCompletionMessageStatus)int int:(isBackupRunning)int;
- (int)setDeviceActivity:(itemRecordingStatus)int;
- (int)trackUserNotifications:(isBluetoothConnected)int int:(surveyAnswerCompletionMessageStatus)int;
- (int)checkAppPermissions:(syncProgress)int;
- (int)getScreenVisitData;
- (void)getSystemNotificationData:(isLocationUpdated)int;
- (void)sendAppReport:(processedFileData)int int:(isDeviceErrorDetected)int;
- (void)trackScreenViews:(itemRecordingStatus)int int:(backgroundColor)int;
- (int)checkConnectivity;
- (void)resetSettings:(sharedPreferences)int;
- (void)trackPushNotifications:(selectedItem)int int:(entityDataPrivacy)int;
- (int)loadSettings:(appLanguageCode)int int:(currentTabIndex)int;
- (void)saveState;
@end