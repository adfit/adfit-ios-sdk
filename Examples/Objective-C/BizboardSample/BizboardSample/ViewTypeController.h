//
//  ViewTypeController.h
//  BizboardSample
//
//  Created by kyle on 2022/11/22.
//

#import <UIKit/UIKit.h>
#import <AdFitSDK/AdFitSDK.h>

NS_ASSUME_NONNULL_BEGIN

@interface ViewTypeController : UIViewController <AdFitNativeAdLoaderDelegate, AdFitNativeAdDelegate>

@property (nonatomic, strong) AdFitNativeAdLoader *nativeAdLoader;
@property (nonatomic, strong) AdFitNativeAd *nativeAd;
@property (nonatomic, strong) BizBoardTemplate* nativeAdView;

@end

NS_ASSUME_NONNULL_END
