STRESTCommand
=============

Provides a simple framework for building REST clients using AFNetworking.

How to install
=============
pod install STRESTCommand

Synopsis
========
Setup the client base URL:

```
[STAPIClient setBaseURL:[NSURL URLWithString:@"https://boss.substantial.com/api/"]];
```

Then create your REST commands by inheriting from STRESTCommand and overriding the parts
you're interested in overriding.  Here's a sample implementation of a command that implements
a user creation request.

```
// UserCreationCommand.h
#import "STRESTCommand.h"
#import "User.h" // a generic user model not included in this example

@protocol UserCreationCommand
- (void)didCreateUser:(User *)user;
- (void)didCompleteWithError:(NSString *)errorMessage;
@end

@interface UserCreationCommand : STRESTCommand
- (instancetype)initWithDelegate:(id<UserCreationCommandDelegate>)delegate;
- (void)executeWithUsername:(NSString *)username password:(NSString *)password;
@end


// UserCreationCommand.m
#import "UserCreationCommand.h"

@implementation UserCreationCommand {
    NSString *username;
    NSString *password;
    __weak id<UserCreationCommandDelegate> delegate;
}

- (instancetype)initWithDelegate:(id<UserCreationCommandDelegate>)aDelegate
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

* The server can return a custom error message along with an error code by returning a json
string in the body: {"errors": "[my message]"}
* All successful responses are assumed to have JSON bodies
