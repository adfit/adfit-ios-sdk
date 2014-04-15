//
//  SampleByIBAppDelegate.h
//  SampleByIB
//
//  Copyright 2012 Daum Communications. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdamAdView.h"

@interface SampleByIBAppDelegate : NSObject <UIApplicationDelegate, AdamAdViewDelegate>

@property (nonatomic, retain) IBOutlet UIWindow *window;

@end
