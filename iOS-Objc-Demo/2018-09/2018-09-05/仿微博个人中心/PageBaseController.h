//
//  PageBaseController.h
//  iOS-Demo
//
//  Created by 吴丹 on 2018/9/6.
//  Copyright © 2018 forever.love. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

UIKIT_EXTERN NSString * const WDPageViewNotification;

typedef NS_ENUM(NSInteger, WDPageViewStyle) {
    WDPageViewStyleNone,
    WDPageViewStyleNavigationBar,
    WDPageViewStyleTabBar,
    WDPageViewStyleNavigationBarAndTabBar,
};

@interface PageBaseController : UIViewController 

@property (nonatomic, strong) UIScrollView *wd_scrollView;
@property (nonatomic, assign) BOOL isCanContentScroll;

- (void)scrollToTop;
- (UIEdgeInsets)defaultScrollContentInsetsWithStyle:(WDPageViewStyle)style;
- (void)wd_scrollViewDidScroll:(UIScrollView *)scrollView;


@end

NS_ASSUME_NONNULL_END
