#import <Foundation/Foundation.h>
@interface ShifterMapHelper : NSObject
- (void)setDeviceModel;
- (int)sendAppSettingsData:(isDeviceInPortraitMode)int int:(filterOptions)int;
- (int)updateLocale:(isMuted)int int:(entityEngagement)int;
- (void)clearUserSettings:(imageUrl)int int:(surveyCompletionTimeTaken)int;
- (void)getAppPermissions;
- (void)initializeErrorTracking;
- (void)getActivityDetails:(currentEntityState)int;
- (int)setInstallTime:(itemPlaybackState)int int:(isValidEmail)int;
@end