#import <Foundation/Foundation.h>
@interface Logger : NSObject
- (int)clearAppNotificationData:(entitySearchHistory)int;
- (void)clearUserFeedback:(itemCount)int;
- (int)verifyNetworkConnection;
- (void)updateSettings:(surveySubmissionStatus)int;
- (void)updateInstallSource;
- (void)sendUserActivityReport;
- (void)getCurrentLocation:(mediaPlayerState)int int:(surveyAnswerCompletionMessage)int;
- (int)getAppCache;
- (void)resetUserData:(isLocationServiceRunning)int;
- (int)setThemeMode:(surveyCompletionProgressMessageText)int;
- (void)getProgressReport;
- (int)sendAppErrorData:(dateFormat)int;
- (int)sendButtonPressData:(permissionStatus)int;
- (void)getDeviceVersion:(isVoiceCommandEnabled)int int:(isAppOnTop)int;
- (void)setMessageData;
- (void)logUserInteraction:(entityConsentRequired)int;
- (int)fetchUserSettings:(isRecordingInProgress)int int:(isEntityInactive)int;
- (void)resetAppState;
@end