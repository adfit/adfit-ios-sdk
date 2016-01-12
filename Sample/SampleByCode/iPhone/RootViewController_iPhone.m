//
//  RootViewController_iPhone.m
//  SampleByCode
//
//  Copyright 2012 Daum Communications. All rights reserved.
//

#import "RootViewController_iPhone.h"
#import "AdamAdView.h"
#import "AdamInterstitial.h"

@implementation RootViewController_iPhone

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    UIImageView *adamTitleImageView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"adam_title"]] autorelease];
    adamTitleImageView.frame = CGRectMake(64.0, 104.0, 193.0, 34.0);
    adamTitleImageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    [self.view addSubview:adamTitleImageView];
    
    UILabel *descLabel = [[[UILabel alloc] initWithFrame:CGRectMake(64.0, 140.0, 193.0, 34.0)] autorelease];
    descLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    descLabel.font = [UIFont systemFontOfSize:12.0];
    descLabel.textAlignment = UITextAlignmentCenter;
    descLabel.text = @"코드로 광고뷰 붙이기 iPhone 샘플";
    [self.view addSubview:descLabel];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(80.0, 200.0, 160.0, 40.0);
    button.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    [button setTitle:@"전면형 광고 호출" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(requestInterstitial) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    AdamAdView *adView = [AdamAdView sharedAdView];
    if (![adView.superview isEqual:self.view]) {
        adView.frame = CGRectMake(0.0, 0.0, self.view.bounds.size.width, 50.0);
        
        adView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        adView.clientId = @"DAN-ursep2xzotib";
        [self.view addSubview:adView];
        
        if (!adView.usingAutoRequest) {
            [adView startAutoRequestAd:60.0];
        }
    }
}

- (void)requestInterstitial
{
    AdamInterstitial *interstitial = [AdamInterstitial sharedInterstitial];
    interstitial.clientId = @"DAN-qy1o35x0mi5e";
    [interstitial requestAndPresent];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - Manage Statusbar

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
