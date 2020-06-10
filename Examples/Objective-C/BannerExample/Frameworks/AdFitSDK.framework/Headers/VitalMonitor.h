//
//  VitalTracker.h
//  AdFitSDK
//
//  Created by KAKAO on 11/01/2019.
//  Copyright © 2019 Kakao Corp. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol VitalMonitorDelegate

- (void)onVitalCrash;

@end

NS_ASSUME_NONNULL_BEGIN

@interface VitalMonitor : NSObject

@property (nonatomic) id<VitalMonitorDelegate> delegate;

- (instancetype)initWithDelegate:(id<VitalMonitorDelegate>)delegate filePath:(NSURL *)reportURL;
- (void)start;
- (void)updateUserContext:(NSDictionary *)context;

@end

NS_ASSUME_NONNULL_END


