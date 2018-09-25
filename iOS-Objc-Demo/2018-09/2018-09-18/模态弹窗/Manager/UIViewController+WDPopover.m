//
//  UIViewController+WDPopover.m
//  iOS-Objc-Demo
//
//  Created by 吴丹 on 2018/9/18.
//  Copyright © 2018 forever.love. All rights reserved.
//

#import "UIViewController+WDPopover.h"
#import <objc/runtime.h>

static const char popoverAnimatorKey;
@implementation UIViewController (WDPopover)

- (WDPopoverAnimator *)popoverAnimator{
    return objc_getAssociatedObject(self, &popoverAnimatorKey);
}
- (void)setPopoverAnimator:(WDPopoverAnimator *)popoverAnimator{
    objc_setAssociatedObject(self, &popoverAnimatorKey, popoverAnimator, OBJC_ASSOCIATION_RETAIN) ;
}

- (void)wd_bottomPresentController:(UIViewController *)vc presentedHeight:(CGFloat)height completeHandle:(WDCompleteHandle)completion{
    self.popoverAnimator = [WDPopoverAnimator popoverAnimatorWithStyle:WDPopoverTypeActionSheet completeHandle:completion];
    
    vc.modalPresentationStyle = UIModalPresentationCustom;
    vc.transitioningDelegate = self.popoverAnimator;
    [self.popoverAnimator setBottomViewHeight:height];
    
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)wd_centerPresentController:(UIViewController *)vc presentedSize:(CGSize)size completeHandle:(WDCompleteHandle)completion{
    self.popoverAnimator = [WDPopoverAnimator popoverAnimatorWithStyle:WDPopoverTypeAlert completeHandle:completion];
    [self.popoverAnimator setCenterViewSize:size];
    
    vc.modalPresentationStyle = UIModalPresentationCustom;
    vc.transitioningDelegate = self.popoverAnimator;
    [self presentViewController:vc animated:YES completion:nil];
}


@end
