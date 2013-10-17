#import "AFJSONRequestOperation.h"
#import "STAPIClient.h"
#import "STRemoteCommand.h"

@implementation STRemoteCommand

- (NSString *)httpMethod {
    return @"GET";
}

- (NSString *)path {
    [self requireOverride];
    return nil;
}

- (NSDictionary *)parameters {
    return [NSDictionary new];
}

- (BOOL)hasAttachment {
    return NO;
}

- (void)addAttachment:(id<AFMultipartFormData>)formData
{

}

- (void)didReceiveUploadProgressWithBytesWritten:(long long)bytesWritten outOf:(long long)totalBytes
{

}

- (void)didCompleteWithSuccess:(id)json {
    [self requireOverride];
}

- (void)didCompleteWithError:(NSString *)errorMessage {
    [self requireOverride];
}

- (void)execute {
    NSMutableURLRequest *request;
    if ([self hasAttachment]) {
        request = [[self client] multipartFormRequestWithMethod:[self httpMethod] path:[self path] parameters:[self parameters] constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            [self addAttachment:formData];
        }];
    } else {
        request = [[self client] requestWithMethod:[self httpMethod] path:[self path] parameters:[self parameters]];
    }


    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id json) {
        [self didCompleteWithSuccess:json];
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id json) {
        NSString *errorMessage = [self parseErrorJson:json];
        [self didCompleteWithError:errorMessage];
    }];
    
#ifdef DEBUG
    operation.allowsInvalidSSLCertificate = YES;
#endif

    if ([self hasAttachment]) {
        [operation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
            [self didReceiveUploadProgressWithBytesWritten:totalBytesWritten outOf:totalBytesExpectedToWrite];
        }];
    }

    [[self client] enqueueHTTPRequestOperation:operation];
}

- (STAPIClient *)client
{
    return [STAPIClient sharedClient];
}

- (NSString *)parseErrorJson:(id)json {
    NSString *message = STRemoteCommandGenericErrorMessage;
    if (json && [json objectForKey:@"errors"]) {
        message = [json[@"errors"] componentsJoinedByString:@"; "];
    }

    return message;
}

- (void)requireOverride {
    NSAssert(NO, @"Override in subclass");
}

@end
