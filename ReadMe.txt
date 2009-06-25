
OAuth Test Application
original source written by Isaiah Carew
© YourHead Software 2009 - All rights reserved.
http://yourhead.com


I created this application to demonstrate the user interaction of the OAuth authentication API for Twitter.

The goal of this app is to find a user experience that is as simple as using a username/password pair.

Instead of the username/password pair this app uses the OAuth authentication system to ask the user to authenticate the application.  The application then stores an access token from this authentication into the Mac OS X Keychain.  All subsequent uses will use the access code stored in the keychain.

This is not meant to be a complete twitter client.



Example:
I've included a compiled example with my own OAuth keys.
I did this so that you have an example of how the app should behave after you insert your own keys obtained from twitter.  You can find the example in:
OAuth_ObjC_Test_App/Example/



To Use:
You will need to create an OAuth applicaton registration on the Twitter site:
 http://twitter.com/oauth_clients/new
Use the key and secret info provided there to modify the constants at the top of YHOAuthTwitterEngine.m
You should also set up your callback url at the top of the YHTwitter.m



Built using:
MGTwitterEngine by Matt Gemmell
http://mattgemmell.com
License:  http://mattgemmell.com/license
I have included 1.0.8 release of the MGTwitterEngine unchanged in this project.  
The goal is to create an easily builable project that has no dependancies.


OAuthConsumer Framework
Jon Crosby
http://code.google.com/p/oauth/
License:  http://www.apache.org/licenses/LICENSE-2.0
I have included a pre-built binary of the OAuthConsumer Framework unchanged in this project.  
The goal is to create an easily builable project that has no dependancies.


OAuth-MyTwitter
Chris Kimpton
http://github.com/kimptoc/MGTwitterEngine-1.0.8-OAuth-MyTwitter/tree/master
License:  Couldn't find one.  Will amend this if I do.
Some code from this project was used to create the YHOATwitterEngine subclass of MGTwitterEngine.
Thanks Chris, you made this project a simple!

