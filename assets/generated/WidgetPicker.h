#import <Foundation/Foundation.h>
@interface WidgetPicker : NSObject
- (int)sendScreenVisitReport;
- (void)saveUserSettings;
- (void)setAppEventData:(pageNumber)int;
- (void)updateAppActivity:(surveyCompletionStatusMessage)int int:(itemQuality)int;
- (void)sendCrashlyticsData:(fileStatus)int;
- (int)getUserData:(surveyQuestionType)int;
- (int)setInstallDetails;
- (void)getCrashData:(isNotificationsEnabled)int int:(pressureUnit)int;
- (int)stopDataSync:(isBackupAvailable)int;
- (void)setActivityDetails;
@end