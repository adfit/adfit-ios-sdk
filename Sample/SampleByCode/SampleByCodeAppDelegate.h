//
//  SampleByCodeAppDelegate.h
//  SampleByCode
//
//  Copyright 2012 Daum Communications. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdamAdView.h"
#import "AdamInterstitial.h"

@interface SampleByCodeAppDelegate : NSObject <UIApplicationDelegate, AdamAdViewDelegate, AdamInterstitialDelegate>

@property (nonatomic, retain) IBOutlet UIWindow *window;

@end
