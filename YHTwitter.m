//
//  YHTwitter.m
//
//  Created by Isaiah Carew on 24 June 2009.
//  Copyright 2009 YourHead Software.
//
//  Some code and concepts taken from examples provided by 
//  Matt Gemmell and Chris Kimpton
//  See ReadMe for further attributions, copyrights and license info.
//

#import <WebKit/WebKit.h>

#import "YHOAuthTwitterEngine.h"
#import "YHTwitterDelegate.h"

#import "YHTwitter.h"


//
// This should be set to the Callback URL in the Twitter new application page
//
// http://twitter.com/oauth_clients/new
// 
#define kYHOAuthTwitterCallbackSuccessURL	@"http://twitter.com/"


//
// This url is the "failure" page at twitter.  Currently this is the URL.
// I wouldn't expect it to change.
//
#define kYHOAuthTwitterCallbackFailURL		@"http://twitter.com/oauth/authorize"


@implementation YHTwitter
@synthesize statuses;

#pragma mark Constructor Destructor
// --------------------------------------------------------------------------------



- (YHTwitter *)init;
{
    if (self = [super init]) {
		
		NSString *username = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
		if ((username) && (![username isEqualToString:@""])) {
			twitterEngine = [YHOAuthTwitterEngine oAuthTwitterEngineWithDelegate:self];
			[twitterEngine setUsername:username password:@""];
			[self doUpdate:self];
		}

    }
    return self;
}



#pragma mark Accessors
// --------------------------------------------------------------------------------



- (NSString *)username;
{
	if (!twitterEngine)
		return nil;
	
	return [twitterEngine username];
}


- (IBAction)doLogin:(id)sender;
{
	twitterEngine = [YHOAuthTwitterEngine oAuthTwitterEngineWithDelegate:self];
	[twitterEngine clearAccessToken];
	[twitterEngine requestRequestToken];
}


- (IBAction)doUpdate:(id)sender;
{
	if ([twitterEngine isAuthorized]) {
		[twitterEngine getFollowedTimelineFor:[twitterEngine username] since:nil startingAtPage:0];
	}
}


- (IBAction)doPost:(id)sender;
{
	if ([twitterEngine isAuthorized]) {
		[twitterEngine sendUpdate:postTextField.stringValue];
		[postTextField setStringValue:@""];
	}
	
	[self doUpdate:self];
}


- (IBAction)doAbout:(id)sender;
{
	[aboutBox makeKeyAndOrderFront:self];
}


#pragma mark Web Sheet
// --------------------------------------------------------------------------------



- (IBAction)doOpenWebSheet:(id)sender;
{
	if (![mainWindow isVisible])
		[mainWindow makeKeyAndOrderFront:self];
	[NSApp beginSheet:webSheet modalForWindow:mainWindow modalDelegate:self didEndSelector:@selector(webSheetDidEnd:returnCode:contextInfo:) contextInfo:nil];
}


- (IBAction)doCloseWebSheet:(id)sender;
{
	[webSheet endEditingFor:nil];
	if (sender == self) {
		[NSApp endSheet:webSheet returnCode:100];
		return;
	}
	
    [NSApp endSheet:webSheet returnCode:[sender tag]];
}



- (void)webSheetDidEnd:(NSWindow*)sheet returnCode:(int)returnCode contextInfo:(void*)contextInfo;
{	
	if (returnCode == 100) {
		[twitterEngine requestAccessToken];
	}
	
    [sheet orderOut:self];	
}



#pragma mark OAuth delegate
// --------------------------------------------------------------------------------



- (void)receivedRequestToken:(id)sender;
{
	[[webview mainFrame] loadRequest:[twitterEngine authorizeURL]];
	[self doOpenWebSheet:self];
}


- (void)receivedAccessToken:(id)sender;
{
	// when we receive an access token we also get to know the username
	[self willChangeValueForKey:@"username"];
	[[NSUserDefaults standardUserDefaults] setValue:self.username forKey:@"username"];
	[self didChangeValueForKey:@"username"];
	
	[self doUpdate:self];
}



#pragma mark WebFrame Load Delegate
// --------------------------------------------------------------------------------



- (void)webView:(WebView *)sender didFinishLoadForFrame:(WebFrame *)frame;
{	
	// if we got a success then we can close this webview
	// success is our success URL with the oauth request token tacked on.
	if ([[[NSURL URLWithString:[sender mainFrameURL]] host] isEqualToString:[NSString stringWithFormat:@"%@?oauth_token=%@", kYHOAuthTwitterCallbackFailURL, [twitterEngine.requestToken key]]]) {
		[self doCloseWebSheet:self];
	}
	
	// if we got a success then we can close this webview
	// the fail url is just the twitter authorize page
	if ([[sender mainFrameURL] isEqualToString:kYHOAuthTwitterCallbackFailURL]) {
		[self doCloseWebSheet:self];
	}
}

@end
