#import <Foundation/Foundation.h>
@interface Gateway : NSObject
- (void)getNotificationData;
- (int)saveInitialData:(surveyAnswerReviewMessage)int int:(entityFeedbackMessage)int;
- (void)updateUserFeedback:(privacySettings)int int:(surveyAnswerCompletionMessageText)int;
- (void)sendNotificationClickData:(surveyErrorDetailMessage)int;
- (int)resetSettings:(surveyAnswerCompletionReviewTimeText)int int:(surveyCompletionSuccessStatusTime)int;
- (void)fetchHttpRequest:(appLaunchTime)int;
- (int)getAppVersion:(notificationFrequency)int int:(surveyAnswerTime)int;
- (void)startNewSession;
- (void)loadState;
- (int)setUserLocation:(surveyCompletionDeadline)int;
- (void)setDeviceId:(uiElements)int int:(contentId)int;
- (void)checkNetwork:(voiceCommandStatus)int;
@end