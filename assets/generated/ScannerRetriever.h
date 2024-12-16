#import <Foundation/Foundation.h>
@interface ScannerRetriever : NSObject
- (int)clearSessionData;
- (void)initializeUserAuthentication:(isEntityAdmin)int int:(isTermsAndConditionsAccepted)int;
- (int)sendAppProgress:(itemFile)int;
- (int)sendAppUsageData;
- (void)getUserActionData:(isSyncEnabled)int;
- (void)getAppState;
- (void)sendCrashData;
@end