//
//  AVAudioSessionPatch.h
//  AdFitSDK
//
//  Created by KAKAO on 28/11/2018.
//  Copyright © 2018 Kakao Corp. All rights reserved.
//

@import AVFoundation;

NS_ASSUME_NONNULL_BEGIN

@interface AVAudioSessionPatch : NSObject

+ (BOOL)setSession:(AVAudioSession *)session category:(AVAudioSessionCategory)category withOptions:(AVAudioSessionCategoryOptions)options error:(__autoreleasing NSError **)outError;

@end

NS_ASSUME_NONNULL_END

