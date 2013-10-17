#import "AFNetworking.h"

static NSString *const STRemoteCommandGenericErrorMessage = @"There was a problem processing your request. Please try again.";

@interface STRESTCommand : NSObject

- (NSString *)httpMethod;
- (NSString *)path;
- (NSDictionary *)parameters;
- (BOOL)hasAttachment;
- (void)addAttachment:(id<AFMultipartFormData>)formData;
- (void)didReceiveUploadProgressWithBytesWritten:(long long)bytesWritten outOf:(long long)totalBytes;
- (void)didCompleteWithSuccess:(id)json;
- (void)didCompleteWithError:(NSString *)errorMessage;
- (void)execute;

@end
