//
//  YHKeychainController.m
//
//  Created by Isaiah Carew on 24 June 2009.
//  Copyright 2009 YourHead Software.
//

#import "YHKeychainController.h"

static YHKeychainController *_shared;

@implementation YHKeychainController


+ (YHKeychainController *)sharedKeychainController;
{
	if (_shared)
		return _shared;
	
	_shared = [[YHKeychainController alloc] init];
	return _shared;
}


- (YHKeychainController *)init;
{
    if (self = [super init]) {
    }

    return self;
}


- (void)dealloc;
{
	if (_shared)
		[_shared release];
	_shared = nil;
	
	[super dealloc];
}


- (NSString *)passwordForUsername:(NSString *)username;
{
	
	if (!username) {
		return @"";
	}
	
	if ([username isEqualToString:@""]) {
		return @"";
	}
	
	const char *theUsernameUTF8 = [username UTF8String];
	if (!theUsernameUTF8) {
		return @"";
	}
	
	UInt32 theUsernameLength = strlen (theUsernameUTF8);
	if (theUsernameLength < 1) {
		return @"";
	}
	
	
	NSString *serviceName = [[[NSBundle bundleForClass:[self class]] infoDictionary] valueForKey:@"CFBundleName"];
	if ((!serviceName) || (serviceName.length < 1)) {
		return @"";
	}
	
	const char *theServiceNameUTF8 = [serviceName UTF8String];
	if (!theServiceNameUTF8) {
		return @"";
	}
	
	UInt32 theServiceNameLength = strlen (theServiceNameUTF8);
	if (theServiceNameLength < 1) {
		return @"";
	}	
	
	
	UInt32 thePasswordLength = 0;
	void *thePasswordUTF8 = NULL;
	SecKeychainItemRef itemRef = NULL;
	OSStatus status = SecKeychainFindGenericPassword (
													  NULL,					// default keychain
													  theServiceNameLength,	// length of service name
													  theServiceNameUTF8,	// service name
													  theUsernameLength,	// length of account name
													  theUsernameUTF8,		// account name
													  &thePasswordLength,	// length of password
													  &thePasswordUTF8,		// pointer to password data
													  &itemRef				// the item reference
													  );
	
	
	if (status == noErr) {
		if (!thePasswordUTF8) {
			return @"";
		}
		NSString *thePassword = [NSString stringWithCString:thePasswordUTF8 length:thePasswordLength];
		status = SecKeychainItemFreeContent (
											 NULL,				//No attribute data to release
											 thePasswordUTF8    //Release data buffer allocated by SecKeychainFindGenericPassword
											 );
		return thePassword;
	}
	
	return @"";
}


- (void)setPassword:(NSString *)password forUserName:(NSString *)username;
{
	if ((!username) || (!password)) {
		return;
	}
	
	if ([username isEqualToString:@""]) {
		return;
	}
	
	
	const char *theUsernameUTF8 = [username UTF8String];
	if (!theUsernameUTF8) {
		return;
	}
	
	UInt32 theUsernameLength = strlen (theUsernameUTF8);
	if (theUsernameLength < 1) {
		return;
	}
	
	
	NSString *serviceName = [[[NSBundle bundleForClass:[self class]] infoDictionary] valueForKey:@"CFBundleName"];
	if ((!serviceName) || (serviceName.length < 1)) {
		return;
	}
	
	const char *theServiceNameUTF8 = [serviceName UTF8String];
	if (!theServiceNameUTF8) {
		return;
	}
	
	UInt32 theServiceNameLength = strlen (theServiceNameUTF8);
	if (theServiceNameLength < 1) {
		return;
	}	
	
		
	const char *thePasswordUTF8 = [password UTF8String];
	if (!thePasswordUTF8) {
		return;
	}
	
	UInt32 thePasswordLength = strlen (thePasswordUTF8);

	UInt32 dummyLength = 0;
	void *dummyString = NULL;
	SecKeychainItemRef itemRef = NULL;
	OSStatus status = SecKeychainFindGenericPassword (
													  NULL,					// default keychain
													  theServiceNameLength,	// length of service name
													  theServiceNameUTF8,	// service name
													  theUsernameLength,	// length of account name
													  theUsernameUTF8,		// account name
													  &dummyLength,			// length of password
													  &dummyString,			// pointer to password data
													  &itemRef				// the item reference
													  );
	
	if (itemRef) {
		status = SecKeychainItemModifyAttributesAndData (
														 itemRef,			// the item reference
														 NULL,				// no change to attributes
														 thePasswordLength,	// length of password
														 thePasswordUTF8	// pointer to password data
														 );
		
	} else {
		
		status = SecKeychainAddGenericPassword (
												NULL,						// default keychain
												theServiceNameLength,	// length of service name
												theServiceNameUTF8,	// service name
												theUsernameLength,			// length of account name
												theUsernameUTF8,			// account name
												thePasswordLength,			// length of password
												thePasswordUTF8,			// pointer to password data
												NULL						// the item reference
												);
	}
}




@end
