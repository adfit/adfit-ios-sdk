//
//  ViewTypeController.m
//  BizboardSample
//
//  Created by kyle on 2022/11/22.
//

#import "ViewTypeController.h"
#import <AdFitSDK/AdFitSDK-Swift.h>

@interface ViewTypeController ()

@end

@implementation ViewTypeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.nativeAdView = [[BizBoardTemplate alloc] initWithFrame: CGRectZero];

    //인스턴스 커스텀
    
    //nativeAdView.bgViewColor = .yellow //배경 색 지정
    //self.nativeAdView.bgViewleftMargin = 16; //좌측 여백
    //self.nativeAdView.bgViewRightMargin = 16; //우측 여백
    //self.nativeAdView.bgViewTopMargin = 10; //상측 여백
    //self.nativeAdView.bgViewBottomMargin = 10; //하측 여백
    // 여백값의 커스텀은 뷰의 높이 계산전에 세팅되어야 한다.

    double viewWidth = self.view.frame.size.width; // 실제 뷰의 너비
    double leftRightMargin = self.nativeAdView.bgViewleftMargin + self.nativeAdView.bgViewRightMargin; // 비즈보드 좌우 마진의 합
    double topBottomMargin = self.nativeAdView.bgViewTopMargin + self.nativeAdView.bgViewBottomMargin; // 비즈보드 상하 마진의 합
    double bizBoardWidth = viewWidth - leftRightMargin; // 뷰의 실제 너비에서 좌우 마진값을 빼주면 비즈보드 너비가 나온다.
    double bizBoardRatio = 1029.0 / 222.0; // 비즈보드 이미지의 비율
    double bizBoardHeight = bizBoardWidth / bizBoardRatio; // 비즈보드 너비에서 비율값을 나눠주면 비즈보드 높이를 계산 할 수 있다.
    double viewHeight = bizBoardHeight + topBottomMargin; // 비즈보드 높이에서 상하 마진값을 더해주면 실제 그려줄 뷰의 높이를 알 수 있다.
    
    self.nativeAdView.frame = CGRectMake(0, 0, viewWidth, viewHeight);
    
    [self.view addSubview:self.nativeAdView];
    
    self.nativeAdLoader = [[AdFitNativeAdLoader alloc] initWithClientId:@"광고단위를 입력 해주세요." count:1];
    self.nativeAdLoader.delegate = self;
    self.nativeAdLoader.infoIconPosition = AdFitInfoIconPositionTopRight;
    
    [self.nativeAdLoader loadAdWithKeyword:nil];
    // Do any additional setup after loading the view.
}

- (void) viewSafeAreaInsetsDidChange {
    [super viewSafeAreaInsetsDidChange];
    
    CGRect frame = self.nativeAdView.frame;
    frame.origin = self.view.safeAreaLayoutGuide.layoutFrame.origin;
    [self.nativeAdView setFrame:frame];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - AdFitNativeAdLoaderDelegate
- (void)nativeAdLoaderDidReceiveAd:(AdFitNativeAd *)nativeAd {
    NSLog(@"didReceiveAd");
    
    self.nativeAd = nativeAd;
    
    //인포아이콘 조정은 바인드 전에 이뤄줘야 한다.
    self.nativeAd.infoIconRightConstant = -20; //인포아이콘을 우에서 좌로 20
    self.nativeAd.infoIconTopConstant = 5; //인포아이콘을 위에서 아래로 5만큼 이동
    
    [self.nativeAd bind:self.nativeAdView];
    self.nativeAd.delegate = self;
}

- (void)nativeAdLoaderDidFailToReceiveAd:(AdFitNativeAdLoader *)nativeAdLoader error:(NSError *)error {
    NSLog(@"didFailToReceiveAd - error = %@", [error localizedDescription]);
}

#pragma mark - AdFitNativeAdDelegate
- (void)nativeAdDidClickAd:(AdFitNativeAd *)nativeAd {
    NSLog(@"didClickAd");
}

@end
