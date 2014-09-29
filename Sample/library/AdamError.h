//
//  AdamError.h
//  AdamPublisher
//  Version 2.3.1
//
//  Copyright 2012 Daum Communications. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 광고 수신 실패에 대한 에러코드.
 */
typedef enum {
    AdamErrorTypeUnknown,                       // 원인을 알 수 없는 에러.
    AdamErrorTypeNoFillAd,                      // 현재 노출 가능한 광고가 없음.
    AdamErrorTypeNoClientId,                    // Client ID가 설정되지 않았음.
    AdamErrorTypeTooSmallAdView,                // 광고 뷰의 크기가 기준보다 작음.
    AdamErrorTypeInvisibleAdView,               // 광고 뷰가 화면에 보여지지 않고 있음.
    AdamErrorTypeAlreadyUsingAutoRequest,       // 이미 광고 자동요청 기능을 사용하고 있는 상태임.
    AdamErrorTypeTooShortRequestInterval,       // 허용되는 최소 호출 간격보다 짧은 시간 내에 광고를 재요청 했음.
    AdamErrorTypePreviousRequestNotFinished,    // 이전 광고 요청에 대한 처리가 아직 완료되지 않았음.
    AdamErrorTypeOpenedAdExists                 // 이미 열려있는 광고 뷰가 존재함.
} AdamErrorType;

@interface AdamError : NSObject

+ (NSError *)makeError:(AdamErrorType)errorType;

@end
