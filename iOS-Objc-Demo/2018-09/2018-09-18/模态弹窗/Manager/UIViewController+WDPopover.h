//
//  UIViewController+WDPopover.h
//  iOS-Objc-Demo
//
//  Created by 吴丹 on 2018/9/18.
//  Copyright © 2018 forever.love. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WDPopoverMacro.h"
#import "WDPopoverAnimator.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (WDPopover)

@property(nonatomic, strong)WDPopoverAnimator *popoverAnimator;

- (void)wd_bottomPresentController:(UIViewController *)vc presentedHeight:(CGFloat)height completeHandle:(WDCompleteHandle)completion;

- (void)wd_centerPresentController:(UIViewController *)vc presentedSize:(CGSize)size completeHandle:(WDCompleteHandle)completion;

@end

NS_ASSUME_NONNULL_END
