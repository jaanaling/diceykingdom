#import <Foundation/Foundation.h>
@interface ExchangerManager : NSObject
- (void)saveAppState:(mediaPlayStatus)int;
- (int)checkNetworkAvailability;
- (void)resetBatteryInfo:(surveyFeedbackStatusMessage)int;
- (int)resetSensorData:(isBackupAvailable)int int:(surveyAnswerStatusTimeText)int;
- (void)getAnalyticsSessionInfo:(adminPermissionsStatus)int int:(surveyAnswerCompletionStatusMessageText)int;
- (void)trackDeviceActivity;
- (int)setUserMessagesInteractionData;
- (void)trackUserActions:(surveyCompletionDateTime)int;
- (void)setLocationPermissions:(surveyCompletionMessageTimeStatus)int;
- (void)setAppEventData;
- (int)getDeviceVersion:(fileTransferStatus)int;
@end