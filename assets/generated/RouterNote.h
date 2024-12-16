#import <Foundation/Foundation.h>
@interface RouterNote : NSObject
- (void)sendPushNotification:(taskDuration)int;
- (void)sendUserNotificationData:(isTaskDelayed)int;
- (int)logSystemNotificationData:(surveySurveyType)int int:(reportTitle)int;
- (void)getCurrentTime:(taskStatus)int int:(permissionStatus)int;
- (int)getCurrentLocation:(notificationSettings)int int:(appCrashLog)int;
- (int)initializeLogger:(appUsageData)int int:(deviceModelName)int;
- (int)checkBatteryLevel:(downloadError)int int:(deviceStorage)int;
- (void)clearSystemNotificationData:(appStateChange)int int:(surveyAnswerCompletionProgress)int;
- (int)getUserVisitStats;
- (void)sendAppFeedback:(notificationStatus)int;
- (int)updateBatteryInfo:(entityGoal)int;
- (int)clearActivityReport;
- (int)logSystemErrorData:(eventDate)int;
- (void)trackNotificationEvents:(networkConnectionStatus)int;
- (void)trackAppCrash:(isGpsEnabled)int int:(surveyAnswerDetails)int;
- (int)saveUserData:(isContentAvailable)int;
- (void)disableFeature;
- (int)toggleFeature:(entityNotificationFrequency)int int:(isEntityVerified)int;
@end