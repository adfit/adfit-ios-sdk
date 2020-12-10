//
//  ViewController.m
//  BannerExample
//
//  Created by KAKAO on 2017. 10. 26..
//  Copyright © 2017년 Kakao Corp. All rights reserved.
//

#import "ViewController.h"
#import <AppTrackingTransparency/AppTrackingTransparency.h>

@interface ViewController()<AdFitBannerAdViewDelegate>

@property (nonatomic) AdFitBannerAdView *bannerAdView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //TODO: Info.plist에 Privacy - Tracking Usage Description 반드시 확인하세요.
    
    self.bannerAdView = [[AdFitBannerAdView alloc] initWithClientId:@"Input Your Client ID" adUnitSize:@"320x50"];
    self.bannerAdView.rootViewController = self;
    self.bannerAdView.delegate = self;
    CGRect slice, remainder;
    CGRectDivide(self.view.bounds, &slice, &remainder, 50, CGRectMaxYEdge);
    self.bannerAdView.frame = slice;
    self.bannerAdView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    [self.view addSubview:self.bannerAdView];
    [self loadAd];
}

- (void)loadAd {
    if (@available(iOS 14, *)) {
        [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
            [self.bannerAdView loadAd];
        }];
    } else {
        [self.bannerAdView loadAd];
    }
}

#pragma mark - AdFitBannerAdViewDelegate
- (void)adViewDidReceiveAd:(AdFitBannerAdView *)bannerAdView {
    NSLog(@"didReceiveAd");
}

- (void)adViewDidFailToReceiveAd:(AdFitBannerAdView *)bannerAdView error:(NSError *)error {
    NSLog(@"didFailToReceiveAd - error = %@", [error localizedDescription]);
}

- (void)adViewDidClickAd:(AdFitBannerAdView *)bannerAdView {
    NSLog(@"didClickAd");
}
@end
