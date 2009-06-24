//
//  YHTwitter.h
//
//  Created by Isaiah Carew on 24 June 2009.
//  Copyright 2009 YourHead Software.
//

@interface YHKeychainController : NSObject {

}

+ (YHKeychainController *)sharedKeychainController;

- (NSString *)passwordForUsername:(NSString *)username;
- (void)setPassword:(NSString *)password forUserName:(NSString *)username;

@end

