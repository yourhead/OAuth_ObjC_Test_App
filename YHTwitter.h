//
//  YHTwitter.h
//
//  Created by Isaiah Carew on 24 June 2009.
//  Copyright 2009 YourHead Software.
//
//  Some code and concepts taken from examples provided by 
//  Matt Gemmell and Chris Kimpton
//  See ReadMe for further attributions, copyrights and license info.
//

@class YHOAuthTwitterEngine;
@class YHTwitterDelegate;

@interface YHTwitter : NSObject {

	YHOAuthTwitterEngine	*twitterEngine;
	
	IBOutlet NSWindow		*mainWindow;
	IBOutlet NSWindow		*aboutBox;
	
	IBOutlet NSWindow		*webSheet;
	IBOutlet WebView		*webview;
	
	IBOutlet NSTextField	*postTextField;		
	NSArray					*statuses;
}

- (IBAction)doLogin:(id)sender;
- (IBAction)doUpdate:(id)sender;
- (IBAction)doPost:(id)sender;

- (IBAction)doOpenWebSheet:(id)sender;
- (IBAction)doCloseWebSheet:(id)sender;

- (IBAction)doAbout:(id)sender;

@property (retain) NSArray *statuses;
@property (readonly) NSString *username;

@end
