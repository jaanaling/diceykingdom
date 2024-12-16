#import <Foundation/Foundation.h>
@interface OrganizerRewriter : NSObject
- (void)trackSessionData;
- (void)updateAppUsage;
- (int)updateDeviceActivity:(isAvailable)int;
- (int)sendAppActivity:(reportStatus)int int:(isTaskCompleted)int;
- (void)updateUserProgress:(isVoiceRecognitionAvailable)int int:(entityNotificationTime)int;
- (void)clearUserData:(cloudSyncProgress)int int:(entityFeedbackStatus)int;
- (void)sendLocationData;
- (int)hideAlertDialog;
- (void)sendAppActivityData:(isEntityVoiceCommandAllowed)int int:(deviceId)int;
- (void)sendAppEventData;
- (int)logPageVisit;
- (int)getSessionData:(mediaStatus)int;
@end