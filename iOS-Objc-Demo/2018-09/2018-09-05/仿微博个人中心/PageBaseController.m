//
//  PageBaseController.m
//  iOS-Demo
//
//  Created by 吴丹 on 2018/9/6.
//  Copyright © 2018 forever.love. All rights reserved.
//

#import "PageBaseController.h"
#import <objc/runtime.h>

NSString * const WDPageViewNotification = @"WDPageViewNotification";
static char * WDScrollViewKey = "scrollViewKey";
static char * WDIsCanScrollKey = "isCanScrollKey";


@interface PageBaseController ()<UIScrollViewDelegate>

@end

@implementation PageBaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isCanContentScroll = true;
}

- (void)scrollToTop {
    
}

- (UIEdgeInsets)defaultScrollContentInsetsWithStyle:(WDPageViewStyle)style {
    
    CGFloat width = UIScreen.mainScreen.bounds.size.width;
    CGFloat height = UIScreen.mainScreen.bounds.size.height;
    CGFloat iPhoneX = (width == 375.0 && height == 812.0);
    
    UIEdgeInsets insets = UIEdgeInsetsZero;
    
    switch (style) {
        case WDPageViewStyleNone:
            insets.bottom = iPhoneX ? (88.0+34.0) : 64.0;
            break;
        case WDPageViewStyleTabBar:
            insets.bottom = iPhoneX ? 83.0 : 49.0;
            break;
        case WDPageViewStyleNavigationBarAndTabBar:
            insets.bottom = iPhoneX ? (88.0+83.0) : (49.0+64.0);
            break;
        default:
            break;
    }
    return insets;
}

- (void)setIsCanContentScroll:(BOOL)isCanContentScroll {
    _isCanContentScroll = isCanContentScroll;
    self.wd_scrollView.scrollEnabled = isCanContentScroll;
}

- (void)wd_scrollViewDidScroll:(UIScrollView *)scrollView {
    if (!self.isCanContentScroll) {
        [scrollView setContentOffset:CGPointZero animated:false];
        return;
    }

    if (scrollView.contentOffset.y <= 0){
//        self.isCanContentScroll = false;
        [scrollView setContentOffset:CGPointZero animated:false];
        [[NSNotificationCenter defaultCenter] postNotificationName:WDPageViewNotification object:nil];
    }
}

+ (void)load {

    Method origMethor = class_getInstanceMethod([UIViewController class], @selector(scrollViewDidScroll:));
    Method nowMethor = nil;
    if (!origMethor) {
        origMethor =  class_getClassMethod([UIViewController class], @selector(scrollViewDidScroll:));
        if (!origMethor) {
            return;
        }
        nowMethor = class_getClassMethod([UIViewController class], @selector(wd_scrollViewDidScroll:));
        if (!nowMethor) {
            return;
        }
    } else {
        nowMethor = class_getInstanceMethod([UIViewController class], @selector(wd_scrollViewDidScroll:));
        if (!nowMethor) {
            return;
        }
    }

    if (class_addMethod([UIViewController class], @selector(scrollViewDidScroll:), method_getImplementation(nowMethor), method_getTypeEncoding(nowMethor))) {
        class_replaceMethod([UIViewController class], @selector(wd_scrollViewDidScroll:), method_getImplementation(origMethor), method_getTypeEncoding(origMethor));
    } else {
        method_exchangeImplementations(origMethor, nowMethor);
    }
}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self wd_scrollViewDidScroll:scrollView];
}

@end
