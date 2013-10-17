#import "AFNetworking.h"

static NSString *const SubGenericErrorMessage = @"There was a problem processing your request. Please try again.";

@interface SubCommander : NSObject

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
