#import <Foundation/Foundation.h>
@interface ChannelManagerReferenceManager : NSObject
- (int)clearAppSettings;
- (int)getLoadingState;
- (int)sendMessageNotificationReport:(taskStartTime)int;
- (void)saveUsageStats:(entityPrivacyStatus)int;
- (void)setAppActivity:(dataSyncStatus)int int:(surveyCompletionSuccessTime)int;
- (int)checkPermissionStatus;
- (void)clearDatabase:(isRecordingEnabled)int int:(taskStartStatus)int;
- (int)trackPushNotificationEvents:(appStoreLink)int;
- (int)stopLocationTracking;
- (void)getAppActivityData;
- (void)updateAppSettings:(uploadProgress)int int:(voiceRecognitionError)int;
- (int)initializeDatabase:(isFirstLaunch)int int:(isDeviceInPortraitMode)int;
- (int)deleteFromDatabase;
- (void)hideLoadingIndicator;
@end