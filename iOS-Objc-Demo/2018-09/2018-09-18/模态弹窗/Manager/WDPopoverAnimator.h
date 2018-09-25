//
//  WDPopoverAnimator.h
//  iOS-Objc-Demo
//
//  Created by 吴丹 on 2018/9/18.
//  Copyright © 2018 forever.love. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WDPopoverMacro.h"
NS_ASSUME_NONNULL_BEGIN

@interface WDPopoverAnimator : NSObject<UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate>

@property(nonatomic,assign)CGRect       presentedFrame;
+ (instancetype)popoverAnimatorWithStyle:(WDPopoverType )popoverType completeHandle:(WDCompleteHandle)completeHandle;

- (void)setCenterViewSize:(CGSize)size;
- (void)setBottomViewHeight:(CGFloat)height;

@end

NS_ASSUME_NONNULL_END
