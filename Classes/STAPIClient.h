#import "AFHTTPClient.h"

@interface STAPIClient : AFHTTPClient
+ (STAPIClient *)sharedClient;
+ (void)setBaseURL:(NSURL *)aURL
@end
