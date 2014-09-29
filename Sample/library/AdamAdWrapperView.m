//
//  AdamAdWrapperView.m
//  AdamPublisher
//  Version 2.3.1
//
//  Copyright 2012 Daum Communications. All rights reserved.
//

#import "AdamAdWrapperView.h"
#import "AdamAdView.h"

@implementation AdamAdWrapperView

- (void)displayAdView
{
    AdamAdView *adView = [AdamAdView sharedAdView];
    if (![adView.superview isEqual:self]) {
        adView.frame = self.bounds;
        adView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        adView.clientId = @"TestClientId";
        [self addSubview:adView];
        
        if (!adView.usingAutoRequest) {
            [adView startAutoRequestAd:60.0];
        }
    }
}

- (void)didMoveToWindow
{
    [super didMoveToWindow];
    
    if (self.window) {
        [self displayAdView];
    }
}

@end
