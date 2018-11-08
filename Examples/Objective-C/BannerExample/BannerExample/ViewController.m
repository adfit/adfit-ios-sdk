//
//  ViewController.m
//  BannerExample
//
//  Created by KAKAO on 2017. 10. 26..
//  Copyright © 2017년 Kakao Corp. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    AdFitBannerAdView *bannerAdView = [[AdFitBannerAdView alloc] initWithClientId:@"Input Your Client ID"
                                                                       adUnitSize:@"320x50"];
    bannerAdView.rootViewController = self;
    bannerAdView.delegate = self;
    CGRect slice, remainder;
    CGRectDivide(self.view.bounds, &slice, &remainder, 50, CGRectMaxYEdge);
    bannerAdView.frame = slice;
    bannerAdView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    [self.view addSubview:bannerAdView];
    [bannerAdView loadAd];
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
