//
//  WDPageBaseViewController.m
//  iOS-Objc-Demo
//
//  Created by 吴丹 on 2018/9/12.
//  Copyright © 2018 forever.love. All rights reserved.
//

#import "WDPageBaseViewController.h"

@interface WDPageBaseViewController ()<UIGestureRecognizerDelegate>

@end

@implementation WDPageBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY<0) {
        //离开顶部
        if(self.delegate) {
            [self.delegate scrollViewLeaveAtTheTop:scrollView];
        }
    }
    _scrollView = scrollView;
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    // 首先判断otherGestureRecognizer是不是系统pop手势
    if ([otherGestureRecognizer.view isKindOfClass:NSClassFromString(@"UILayoutContainerView")]) {
        // 再判断系统手势的state是began还是fail，同时判断scrollView的位置是不是正好在最左边
        if (otherGestureRecognizer.state == UIGestureRecognizerStateBegan && self.scrollView.contentOffset.x == 0) {
            return YES;
        }
    }
    
    return NO;
}

@end
