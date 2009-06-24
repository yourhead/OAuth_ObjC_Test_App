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

#import "MGTwitterEngine.h"

@class OAToken;
@class OAConsumer;

@interface YHOAuthTwitterEngine : MGTwitterEngine {
	
	OAConsumer	*_consumer;
	OAToken		*_requestToken;
	OAToken		*_accessToken;
	
}

+ (YHOAuthTwitterEngine *)oAuthTwitterEngineWithDelegate:(NSObject *)theDelegate;
- (YHOAuthTwitterEngine *)initOAuthWithDelegate:(NSObject *)newDelegate;

- (BOOL)isAuthorized;
- (NSURLRequest *)authorizeURL;
- (void)requestAccessToken ;
- (void)requestRequestToken ;
- (void)clearAccessToken;

@property (retain)	OAConsumer	*consumer;
@property (retain)	OAToken		*requestToken;
@property (retain)	OAToken		*accessToken;

@end


@protocol YHOAuthTwitterEngineDelegate 

- (void)receivedRequestToken:(id)sender;
- (void)receivedAccessToken:(id)sender;

@end
