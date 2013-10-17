#import "AFHTTPRequestOperation.h"
#import "STAPIClient.h"

@implementation STAPIClient

static NSURL *baseURL;

+ (STAPIClient *)sharedClient {
    static STAPIClient *sharedClient = nil;
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
