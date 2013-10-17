#import "AFHTTPClient.h"

@interface SubAPIClient : AFHTTPClient
+ (instancetype)sharedClient;
+ (void)setBaseURL:(NSURL *)aURL
@end
