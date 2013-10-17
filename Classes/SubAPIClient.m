#import "AFHTTPRequestOperation.h"
#import "SubAPIClient.h"

@implementation SubAPIClient

static NSURL *baseURL;

+ (instancetype)sharedClient {
    static SubAPIClient *sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedClient = [[self alloc] initWithBaseURL:baseURL];
    });
    
    return sharedClient;
}

+ (void)setBaseURL:(NSURL *)aURL
{
    baseURL = aURL;
}

@end
