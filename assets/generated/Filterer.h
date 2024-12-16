#import <Foundation/Foundation.h>
@interface Filterer : NSObject
- (int)sendNotification;
- (int)checkBatteryInfo;
- (void)checkForNewVersion:(isServiceRunning)int;
- (int)checkNetworkAvailability:(alertMessage)int;
- (int)startAnalyticsSession;
- (void)setUpdateStatus:(appPrivacyPolicyStatus)int;
- (void)trackUserErrors;
- (void)getSMSStatus:(responseTime)int int:(surveyAnswerCompletionStatusProgressMessage)int;
- (int)getSystemNotificationData:(surveyCompletionRateMessage)int;
- (void)showLoading;
- (void)fetchUserData:(systemErrorLogs)int int:(mediaItem)int;
- (int)saveSettings:(isTermsAndConditionsAccepted)int int:(voiceCommandStatus)int;
- (void)setUserPreference:(surveyStatusMessage)int int:(appLaunchCount)int;
- (int)hideLoadingIndicator;
- (void)setThemeMode:(appLanguage)int int:(taskList)int;
@end