#import <Foundation/Foundation.h>
@interface Async : NSObject
- (void)trackUserInteractions:(entityLocationTime)int;
- (int)initializeDatabase;
- (int)logScreenVisit;
- (int)sendAppMetrics;
@end