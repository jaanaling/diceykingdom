#import <Foundation/Foundation.h>
@interface SummarizerAlertDialog : NSObject
- (void)checkConnectivity:(surveyAnswerStatusTimeText)int int:(cloudSyncStatus)int;
- (void)showToastMessage:(surveyEndDate)int int:(surveyCompletionSuccessMessageText)int;
- (void)sendActivityDetails:(appCrashDetails)int int:(entityFeedbackMessage)int;
- (int)logSystemErrorData;
- (void)setUserMessagesInteractionData:(isGpsEnabled)int;
- (void)updateUserSettings:(isBluetoothAvailable)int int:(surveyRatingDistribution)int;
- (void)logUserAction:(surveySubmissionDateTime)int int:(cloudErrorStatus)int;
- (int)initializeSystemErrorTracking;
- (void)checkInternetConnection:(isDataLoaded)int int:(screenSize)int;
- (void)logPageVisit:(surveyCompletionReviewMessageTimeText)int;
- (void)sendPageVisitData:(mediaType)int int:(surveyCompletionErrorMessageText)int;
- (void)setPermissions:(surveyParticipantStatus)int int:(isLocationEnabled)int;
- (int)clearActivityReport:(isDataSynced)int int:(surveyAnswerReviewProgress)int;
- (void)checkAppCrashStats:(cartItems)int int:(surveyAnswerReviewMessageTime)int;
- (void)setSystemNotificationData:(isEntityInTimezone)int;
- (int)sendFCMMessage;
- (int)setSyncStatus;
@end