//
//  CellTypeController.m
//  BizboardSample
//
//  Created by kyle on 2022/11/22.
//

#import "CellTypeController.h"
#import <AdFitSDK/AdFitSDK.h>

@interface CellTypeController ()


@property (nonatomic, strong) AdFitNativeAdLoader *nativeAdLoader;
@property (nonatomic, strong) AdFitNativeAd *nativeAd;
@property (nonatomic, strong) UITableView* tableView;

@property (nonatomic, assign) BOOL isAdHidden;
@property (nonatomic, assign) CGFloat adHeight;

@end

@implementation CellTypeController

static NSString * const adCellName = @"BizBoardListFeedAdTableViewCell";

- (CGFloat)adHeight {
    
    CGFloat deviceWidth = [[UIScreen mainScreen] bounds].size.width; // 디바이스 너비
    CGFloat deviceHeight = [[UIScreen mainScreen] bounds].size.height; // 디바이스 높이
    
    if (deviceWidth > deviceHeight) { // 디바이스 너비값이 디바이스 높이값보다 크다면 (가로모드 상황)
        deviceWidth = deviceHeight; // 디바이스 너비값을 디바이스 높이값으로 사용하도록 한다.
    }
    
    //비즈보드셀 전역 커스텀 설정
    BizBoardCell.defaultEdgeInset = UIEdgeInsetsMake(0, 16, 8, 16); //top, left, bottom, right
    
    // 뷰타입과 다르게 셀타입에서는 비즈보드 개별 여백 설정이 아닌 기본 여백 설정값을 이용하였다.
    CGFloat leftRightMargin = BizBoardCell.defaultEdgeInset.left + BizBoardCell.defaultEdgeInset.right; // 비즈보드 좌우 마진의 합
    CGFloat topBottomMargin = BizBoardCell.defaultEdgeInset.top + BizBoardCell.defaultEdgeInset.bottom; // 비즈보드 상하 마진의 합
    CGFloat bizBoardWidth = deviceWidth - leftRightMargin; // 뷰의 실제 너비에서 좌우 마진값을 빼주면 비즈보드 너비가 나온다.
    CGFloat bizBoardRatio = 1029.0 / 222.0; // 비즈보드 이미지의 비율
    CGFloat bizBoardHeight = bizBoardWidth / bizBoardRatio; // 비즈보드 너비에서 비율값을 나눠주면 비즈보드 높이를 계산 할 수 있다.
    CGFloat cellHeight = bizBoardHeight + topBottomMargin; // 비즈보드 높이에서 상하 마진값을 더해주면 실제 그려줄 뷰의 높이를 알 수 있다.
    
    return cellHeight;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.tableView = [[UITableView alloc] initWithFrame: CGRectZero];
    [self.tableView registerClass:[BizBoardCell self] forCellReuseIdentifier: adCellName];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorColor = [UIColor clearColor];
    self.tableView.frame = self.view.bounds;
    self.tableView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    
    self.nativeAdLoader = [[AdFitNativeAdLoader alloc] initWithClientId:@"광고단위를 입력 해주세요." count:1];
    self.nativeAdLoader.delegate = self;
    self.nativeAdLoader.infoIconPosition = AdFitInfoIconPositionTopRight;
    
    [self.nativeAdLoader loadAdWithKeyword:nil];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.isAdHidden ? 0 : 1;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:adCellName forIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    BizBoardCell *bizCell = (BizBoardCell *)cell;
    
    //인포아이콘 조정은 바인드 전에 이뤄줘야 한다.
    self.nativeAd.infoIconRightConstant = -20; //인포아이콘을 우에서 좌로 20
    self.nativeAd.infoIconTopConstant = 5; //인포아이콘을 위에서 아래로 5만큼 이동
    [self.nativeAd bind:bizCell];
    self.nativeAd.delegate = self;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.adHeight;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.adHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1f;
}

#pragma mark - AdFitNativeAdLoaderDelegate
- (void)nativeAdLoaderDidReceiveAd:(AdFitNativeAd *)nativeAd {
    NSLog(@"didReceiveAd");
    
    self.nativeAd = nativeAd;
    self.isAdHidden = NO;
    [self.tableView reloadData];
}

- (void)nativeAdLoaderDidFailToReceiveAd:(AdFitNativeAdLoader *)nativeAdLoader error:(NSError *)error {
    NSLog(@"didFailToReceiveAd - error = %@", [error localizedDescription]);
    
    self.isAdHidden = YES;
    [self.tableView reloadData];
}

#pragma mark - AdFitNativeAdDelegate
- (void)nativeAdDidClickAd:(AdFitNativeAd *)nativeAd {
    NSLog(@"didClickAd");
}

@end
