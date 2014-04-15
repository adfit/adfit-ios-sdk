//
//  SampleByIBAppDelegate.m
//  SampleByIB
//
//  Copyright 2012 Daum Communications. All rights reserved.
//

#import "SampleByIBAppDelegate.h"

@implementation SampleByIBAppDelegate

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	[[AdamAdView sharedAdView] setDelegate:self];
	
    [self.window makeKeyAndVisible];
    return YES;
}


#pragma mark - AdamAdView Delegate

- (void)didReceiveAd:(AdamAdView *)adView
{
	NSLog(@"didReceiveAd");
}

- (void)didFailToReceiveAd:(AdamAdView *)adView error:(NSError *)error
{
	NSLog(@"didFailToReceiveAd, error: %@", error.localizedDescription);
}

- (void)willOpenFullScreenAd:(AdamAdView *)adView
{
	NSLog(@"willOpenFullScreenAd");
}

- (void)didOpenFullScreenAd:(AdamAdView *)adView
{
    NSLog(@"didOpenFullScreenAd");
}

- (void)willCloseFullScreenAd:(AdamAdView *)adView
{
	NSLog(@"willCloseFullScreenAd");
}

- (void)didCloseFullScreenAd:(AdamAdView *)adView
{
    NSLog(@"didCloseFullScreenAd");
}

- (void)willResignByAd:(AdamAdView *)adView
{
	NSLog(@"willResignByAd");
}

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

@end
