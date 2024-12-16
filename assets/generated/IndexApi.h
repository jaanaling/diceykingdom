#import <Foundation/Foundation.h>
@interface IndexApi : NSObject
- (void)sendUserVisitStats:(surveyParticipantCount)int;
- (void)clearInstallDetails:(isLocationPermissionDenied)int int:(isItemMuted)int;
- (int)trackUserFeedback;
- (int)setActivityDetails;
- (int)setCrashHandler;
- (int)checkDeviceFeatures;
- (void)resetProgressStatus;
- (int)resetCrashReports;
- (int)sendUserMessagesInteractionReport;
- (int)trackUninstallEvents:(loginErrorMessage)int int:(processedFileData)int;
- (int)getCrashData:(isEntityInTimezone)int int:(messageCount)int;
- (int)hideErrorMessage:(isItemRecording)int int:(surveyFeedbackStatusTime)int;
- (int)fetchImage:(isEntityConsentGiven)int;
@end