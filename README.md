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
// CreateUserCommand.h
#import "SubCommander.h"
#import "User.h" // Note: User.h isn't provided in this example

@protocol CreateUserCommandDelegate
- (void)didCreateUser:(User *)user;
- (void)didCompleteWithError:(NSString *)errorMessage;
@end

@interface CreateUserCommand : SubCommander
- (instancetype)initWithDelegate:(id<CreateUserCommandDelegate>)delegate;
- (void)executeWithUsername:(NSString *)username password:(NSString *)password;
@end


// CreateUserCommand.m
#import "CreateUserCommand.h"

@implementation CreateUserCommand {
    NSString *username;
    NSString *password;
    __weak id<CreateUserCommandDelegate> delegate;
}

- (instancetype)initWithDelegate:(id<CreateUserCommandDelegate>)aDelegate
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
    return @"users";
}

- (NSDictionary *)parameters {
    return @{@"user":@{@"username":username, @"password":password}};
}

- (void)didCompleteWithSuccess:(id)json {
    User *user = [[User alloc] initWithDictionary:json];
    [delegate didCreateUser:user];
}

- (void)didCompleteWithError:(NSString *)errorMessage {
    [delegate didCompleteWithError:errorMessage];
}

@end
```

Important Conventions
=====================

* The server can return a custom error message along with an error code by returning a json string in the body: {"errors": "my error message"}
* All successful responses are assumed to have JSON bodies
