//
//  SampleByCodeAppDelegate.m
//  SampleByCode
//
//  Copyright 2012 Daum Communications. All rights reserved.
//

#import "SampleByCodeAppDelegate.h"
#import "RootViewController_iPhone.h"
#import "RootViewController_iPad.h"

@implementation SampleByCodeAppDelegate

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    UIViewController *rootViewController = nil;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        rootViewController = [[[RootViewController_iPad alloc] init] autorelease];
        
    } else {
        rootViewController = [[[RootViewController_iPhone alloc] init] autorelease];
    }
    
    self.window.rootViewController = rootViewController;
	
	[[AdamAdView sharedAdView] setDelegate:self];
    [[AdamInterstitial sharedInterstitial] setDelegate:self];
    
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


#pragma mark - AdmaInterstitial Delegate
- (void)didReceiveInterstitialAd:(AdamInterstitial *)interstitial
{
    NSLog(@"didReceiveInterstitialAd");
}

- (void)didFailToReceiveInterstitialAd:(AdamInterstitial *)interstitial error:(NSError *)error
{
    NSLog(@"didFailToReceiveInterstitialAd, error: %@", error.localizedDescription);
}

- (void)willOpenInterstitialAd:(AdamInterstitial *)interstitial
{
    NSLog(@"willOpenInterstitialAd");
}

- (void)didOpenInterstitialAd:(AdamInterstitial *)interstitial
{
    NSLog(@"didOpenInterstitialAd");
}

- (void)willCloseInterstitialAd:(AdamInterstitial *)interstitial
{
    NSLog(@"willCloseInterstitialAd");
}

- (void)didCloseInterstitialAd:(AdamInterstitial *)interstitial
{
    NSLog(@"didCloseInterstitialAd");
}

- (void)willResignByInterstitialAd:(AdamInterstitial *)interstitial
{
    NSLog(@"willResignByInterstitialAd");
}

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

@end
