SubCommander
=============

iOS Objective-C framework for building testable clients for JSON REST APIs.  Uses AFNetworking under the hood.

How to install
=============
```
pod install SubCommander
```

Synopsis
========
Setup the API client with your base URL:

```
[SubAPIClient setBaseURL:[NSURL URLWithString:@"https://example.com/api/"]];
```

Then create your commands for each API endpoint by inheriting from SubCommander and overriding the parts
you're interested in overriding.  Here's a sample implementation of an endpoint for creating users.

```
// RemoteUserCreator.h
#import "SubCommander.h"
#import "User.h" // a generic user model not included in this example

@protocol RemoteUserCreatorDelegate
- (void)didCreateUser:(User *)user;
- (void)didCompleteWithError:(NSString *)errorMessage;
@end

@interface RemoteUserCreator : SubCommander
- (instancetype)initWithDelegate:(id<RemoteUserCreatorDelegate>)delegate;
- (void)executeWithUsername:(NSString *)username password:(NSString *)password;
@end


// RemoteUserCreator.m
#import "RemoteUserCreator.h"

@implementation RemoteUserCreator {
    NSString *username;
    NSString *password;
    __weak id<RemoteUserCreatorDelegate> delegate;
}

- (instancetype)initWithDelegate:(id<RemoteUserCreatorDelegate>)aDelegate
{
    self = [super init];
    if (self) {
        delegate = aDelegate;
    }
    return self;
}

- (void)executeWithUsername:(NSString *)aUsername password:(NSString *)aPassword
{
    password = aPassword;
    username = aUsername;
    [self execute];
}

- (NSString *)httpMethod {
    return @"POST";
}

- (NSString *)path {
    return @"users"
}

- (NSDictionary *)parameters {
    return @{@"user":@{@"username":username, @"password":password}};
}

- (void)didCompleteWithSuccess:(id)json {
    User *user = [User userWithDictionary:json];
    [delegate didCreateUser:user];
}

- (void)didCompleteWithError:(NSString *)errorMessage {
    [delegate didCompleteWithError:errorMessage];
}

@end
```

Important Conventions
=====================

* The server can return a custom error message along with an error code by returning a json string in the body: {"errors": "[my message]"}
* All successful responses are assumed to have JSON bodies
