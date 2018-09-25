//
//  WDPageBaseViewController.h
//  iOS-Objc-Demo
//
//  Created by 吴丹 on 2018/9/12.
//  Copyright © 2018 forever.love. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol scrollDelegate <NSObject>

-(void)scrollViewLeaveAtTheTop:(UIScrollView *)scrollView;

@end

@interface WDPageBaseViewController : UIViewController

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, assign) BOOL canScroll;
@property (nonatomic, weak) id<scrollDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
