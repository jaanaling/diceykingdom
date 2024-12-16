#import <Foundation/Foundation.h>
@interface DownloaderEstablisher : NSObject
- (void)loadAppState:(appThemeColor)int int:(isDeviceInDoNotDisturbMode)int;
- (void)getUserActivity:(appLanguageCode)int;
- (int)enableFeature:(entitySession)int;
- (void)getReminderDetails;
- (int)setInstallDetails:(entityTaskStatus)int int:(surveyCompletionSuccessTime)int;
- (int)sendPostRequest:(isSurveyAnonymous)int;
@end