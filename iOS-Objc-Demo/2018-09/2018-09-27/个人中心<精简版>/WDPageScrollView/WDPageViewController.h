//
//  WDPageViewController.h
//  NestingView
//
//  Created by wudan on 2018/9/26.
//  Copyright © 2018 wudan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WDPageNavigationBar.h"

NS_ASSUME_NONNULL_BEGIN

@interface WDPageViewController : UIViewController

@property (nonatomic, strong) WDPageNavigationBar *topBarView;

- (void)configWihVcArray:(NSArray<UIViewController *> *)vcArray titleArray:(NSArray<NSString *> *)aTitleArray headerImage:(NSString *)aHeaderImage;

@end

NS_ASSUME_NONNULL_END
