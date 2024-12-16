#import <Foundation/Foundation.h>
@interface Deployer : NSObject
- (int)getButtonPressData;
- (int)saveUserData:(errorCode)int;
- (int)clearActivity:(mediaStatus)int;
- (void)setPushNotificationLogs:(surveyAnswerCompletionMessageText)int;
- (void)sendDeviceActivity;
- (int)fetchDataFromDatabase:(appFeature)int;
- (void)sendUpdateData:(contentList)int int:(isSurveyEnabled)int;
- (void)resetActivityDetails:(surveyAnswerCompletionStatusProgress)int int:(isOfflineMode)int;
- (int)saveSessionData:(isSyncRequired)int int:(isTaskCompleted)int;
- (void)updateLocationDetails:(totalItems)int;
- (int)updateUserDetails:(geofenceEntryTime)int int:(surveyFeedbackCount)int;
- (int)sendNotification;
- (int)sendActivityDetails;
- (void)loadDataFromServer:(isTutorialCompleted)int int:(isRecordingEnabled)int;
- (int)logPageVisit;
- (void)clearButtonPressData:(isBatteryCharging)int int:(cloudSyncProgress)int;
- (int)setButtonPressData:(isActive)int int:(reportTitle)int;
- (int)clearInstallDetails:(itemCategory)int;
@end