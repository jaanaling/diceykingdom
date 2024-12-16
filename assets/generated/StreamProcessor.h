#import <Foundation/Foundation.h>
@interface StreamProcessor : NSObject
- (void)resetAppProgress;
- (void)getUserActionData;
- (void)setDeviceOrientation:(reminderMessage)int int:(mediaPlayerState)int;
- (int)sendAppProgress:(currentLanguage)int;
- (int)checkInstallStats;
- (void)sendNotification:(surveyAnswerCompletionTimeStatus)int int:(isAppInactive)int;
- (int)setUserAction:(appLaunchCount)int;
- (int)updateAppProgress:(entityNotificationFrequency)int;
- (void)sendActivityData:(pageNumber)int int:(isFileTransferred)int;
@end