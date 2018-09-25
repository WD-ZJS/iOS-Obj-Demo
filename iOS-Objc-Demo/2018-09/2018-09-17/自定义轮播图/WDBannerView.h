//
//  WDBannerView.h
//  iOS-Objc-Demo
//
//  Created by 吴丹 on 2018/9/17.
//  Copyright © 2018 forever.love. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WDBannerView : UIView

- (instancetype)initLoadLocalBannerWithImageArray:(NSArray<NSString *> *)imageArray;

- (instancetype)initLoadInterBannerWithImageArray:(NSArray<NSString *> *)imageArray;

@end

NS_ASSUME_NONNULL_END
