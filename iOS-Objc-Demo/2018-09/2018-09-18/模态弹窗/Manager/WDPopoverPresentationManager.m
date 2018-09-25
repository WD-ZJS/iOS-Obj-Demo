//
//  WDPopoverPresentationManager.m
//  iOS-Objc-Demo
//
//  Created by 吴丹 on 2018/9/18.
//  Copyright © 2018 forever.love. All rights reserved.
//

#import "WDPopoverPresentationManager.h"

@interface WDPopoverPresentationManager () <UIPopoverPresentationControllerDelegate>

@end

@implementation WDPopoverPresentationManager

- (void)setupPopoverPresentationWithFromController:(UIViewController *)fromController
                               presentedController:(UIViewController *)aPresentedController
                                   backgroundColor:(UIColor *)aBackgroundColor
                              preferredContentSize:(CGSize)aPreferredContentSize
                                        sourceView:(UIView *)aSourceView
                                        sourceRect:(CGRect)aSourceRect
                          permittedArrowDirections:(UIPopoverArrowDirection)aPermittedArrowDirections {

    if (aPreferredContentSize.width != 0 && aPreferredContentSize.height != 0) {
        aPresentedController.preferredContentSize = aPreferredContentSize;
    }
    
    aPresentedController.modalPresentationStyle = UIModalPresentationPopover;
    UIPopoverPresentationController *popover = aPresentedController.popoverPresentationController;
    popover.delegate = self;
    popover.backgroundColor = aBackgroundColor;
    popover.sourceView = aSourceView;
    popover.permittedArrowDirections = aPermittedArrowDirections;
    [fromController presentViewController:aPresentedController animated:YES completion:nil];
}

#pragma mark --  实现代理方法
//默认返回的是覆盖整个屏幕，需设置成UIModalPresentationNone。
- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller {
    return UIModalPresentationNone;
}

//点击蒙版是否消失，默认为yes；
- (BOOL)popoverPresentationControllerShouldDismissPopover:(UIPopoverPresentationController *)popoverPresentationController {
    return NO;
}

// 弹框消失时调用的方法
- (void)popoverPresentationControllerDidDismissPopover:(UIPopoverPresentationController *)popoverPresentationController {
    NSLog(@"弹框已经消失");
}

- (void)prepareForPopoverPresentation:(UIPopoverPresentationController *)popoverPresentationController {
    NSLog(@"%@",popoverPresentationController);
}

@end
