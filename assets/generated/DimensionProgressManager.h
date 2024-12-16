#import <Foundation/Foundation.h>
@interface DimensionProgressManager : NSObject
- (int)checkAppCrashStats;
- (int)sendEventWithParams:(notificationFrequency)int;
- (int)getAppActivityData:(appUpdateInfo)int int:(isMuted)int;
- (int)checkUserAuthentication:(surveyCompletionMessage)int int:(surveyAnswerStatus)int;
- (void)launchApp:(surveyAnswerProgress)int;
- (int)checkDeviceFeatures;
- (void)setUserLocation:(isAppCrashDetected)int int:(appState)int;
- (int)trackSystemNotifications:(gpsLocationAccuracy)int;
- (void)trackButtonPress:(errorDetailsMessage)int;
- (void)resetAppState:(surveyCompletionNotificationStatus)int int:(isFileCompressionEnabled)int;
- (int)requestLocationUpdate;
- (void)grantPermission;
- (void)setUserProgress:(isAppReadyForUse)int int:(backupStatus)int;
- (void)clearPushNotification:(surveyCompletionSuccessMessage)int;
- (int)trackSensorData:(isGpsEnabled)int int:(entityConsentStatus)int;
- (int)savePreference:(timeZoneOffset)int;
- (void)resetCrashReports;
@end