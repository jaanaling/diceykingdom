#import <Foundation/Foundation.h>
@interface ForegroundPipelineManager : NSObject
- (void)getUserStatusReport;
- (void)clearUserData:(surveyCompletionErrorMessageStatus)int int:(entitySession)int;
- (void)getInteractionDetails:(locationUpdateStatus)int;
- (int)logCrashLogs:(reminderTime)int;
- (int)clearCache:(surveyFeedbackCompletionMessage)int;
- (int)fetchUserProfile;
- (void)sendUpdateRequest:(currentStep)int;
- (int)setProgressStatus:(appInMemoryUsage)int;
- (int)logScreenView;
- (void)getBatteryStatus:(currentStep)int;
- (int)revokePermission:(taskResumeTime)int;
@end