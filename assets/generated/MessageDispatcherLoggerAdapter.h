#import <Foundation/Foundation.h>
@interface MessageDispatcherLoggerAdapter : NSObject
- (int)sendUserVisitStats:(taskProgressStatus)int;
- (int)trackUserInteractions:(appLanguage)int int:(totalSteps)int;
- (int)logUserAction:(surveyCompletionTimeTaken)int int:(appFeatureEnabled)int;
- (int)getLocale;
- (void)getUserProfile:(surveyParticipantCount)int int:(isSubscribed)int;
- (int)sendAnalytics:(cloudErrorStatus)int int:(surveyCompletionSuccessMessage)int;
- (int)setSessionStatus:(screenHeight)int int:(deviceStorageStatus)int;
@end