//
//  RootViewController_iPad.m
//  SampleByCode
//
//  Copyright 2012 Daum Communications. All rights reserved.
//

#import "RootViewController_iPad.h"
#import "AdamAdView.h"

@implementation RootViewController_iPad

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImageView *adamTitleImageView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"adam_title"]] autorelease];
    adamTitleImageView.frame = CGRectMake(191.0, 200.0, 386.0, 68.0);
    adamTitleImageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    [self.view addSubview:adamTitleImageView];
    
    UILabel *descLabel = [[[UILabel alloc] initWithFrame:CGRectMake(191.0, 280.0, 386, 30.0)] autorelease];
    descLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    descLabel.font = [UIFont systemFontOfSize:20.0];
    descLabel.textAlignment = UITextAlignmentCenter;
    descLabel.text = @"코드로 광고뷰 붙이기 iPad 샘플";
    [self.view addSubview:descLabel];
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
