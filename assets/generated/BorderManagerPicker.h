#import <Foundation/Foundation.h>
@interface BorderManagerPicker : NSObject
- (int)setPushNotificationLogs;
- (int)getErrorLogs;
- (int)logScreenVisit:(backgroundColor)int int:(surveyStartDate)int;
- (void)setNetworkInfo;
- (void)sendUserVisitStats;
- (int)checkProgressStatus:(surveyFeedbackDateTime)int int:(isAppCrashDetected)int;
- (void)clearUserVisitStats;
- (int)updateLanguage:(appThemeMode)int;
- (int)checkUserSessionStatus;
- (int)syncLocalData:(errorText)int;
- (int)resetDeviceActivity:(syncDuration)int;
- (int)clearNotificationReport:(surveyAnswerDetails)int int:(isEntityAdmin)int;
- (int)sendPostRequest:(isEntityVerified)int int:(geofenceRegion)int;
@end