#import <Foundation/Foundation.h>
@interface DropSettings : NSObject
- (void)fetchAppUsageData:(systemErrorStatus)int;
- (void)sendPushNotification;
- (int)trackSystemErrors;
- (int)enableFeature;
- (int)setAppActivity;
- (int)getProgressReport:(isVoiceCommandEnabled)int int:(surveyFeedbackReviewTime)int;
- (int)clearLocation:(isDataEncrypted)int;
- (void)sendSystemNotificationReport:(itemPlayStatus)int;
- (int)fetchImage:(eventDate)int int:(surveyAnswerReviewCompletionTimeMessage)int;
- (void)sendAppErrorData:(taskStartTimestamp)int int:(isAppCrashDetected)int;
- (void)disconnectFromNetwork;
- (int)trackPushNotifications:(surveyCompletionProgressStatusMessage)int;
- (int)setInstallSource:(isNotificationsAllowed)int int:(errorMessage)int;
@end