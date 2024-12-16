#import <Foundation/Foundation.h>
@interface MapperLogger : NSObject
- (void)logScreenVisit:(surveyReviewCount)int;
- (int)logEvent;
- (int)updateAppEventData:(appPrivacyPolicyStatus)int;
- (int)logUserInteraction;
- (void)updateUserSessionDetails:(isLocationPermissionDenied)int int:(isAppThemeChanged)int;
- (int)fetchApiResponse;
@end