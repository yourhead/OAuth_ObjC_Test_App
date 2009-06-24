//
//  YHTwitterDelegate.m
//
//  Created by Isaiah Carew on 24 June 2009.
//  Copyright 2009 YourHead Software.
//
//  Some code and concepts taken from examples provided by 
//  Matt Gemmell and Chris Kimpton
//  See ReadMe for further attributions, copyrights and license info.
//

#import <WebKit/WebKit.h>
#import "YHTwitterDelegate.h"


@implementation YHTwitter (TwitterDelegate)

- (void)requestSucceeded:(NSString *)requestIdentifier
{
    NSLog(@"Request succeeded (%@)", requestIdentifier);
}


- (void)requestFailed:(NSString *)requestIdentifier withError:(NSError *)error
{
    NSLog(@"Twitter request failed! (%@) Error: %@ (%@)", 
          requestIdentifier, 
          [error localizedDescription], 
          [[error userInfo] objectForKey:NSErrorFailingURLStringKey]);
}


- (void)statusesReceived:(NSArray *)newStatuses forRequest:(NSString *)identifier
{
	self.statuses = newStatuses;
}


- (void)directMessagesReceived:(NSArray *)messages forRequest:(NSString *)identifier
{
}


- (void)userInfoReceived:(NSArray *)userInfo forRequest:(NSString *)identifier
{
}


- (void)miscInfoReceived:(NSArray *)miscInfo forRequest:(NSString *)identifier
{
}


- (void)imageReceived:(NSImage *)image forRequest:(NSString *)identifier
{
}

@end
