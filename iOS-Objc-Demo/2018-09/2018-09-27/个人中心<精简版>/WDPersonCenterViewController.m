//
//  WDPersonCenterViewController.m
//  iOS-Objc-Demo
//
//  Created by wudan on 2018/9/27.
//  Copyright © 2018 forever.love. All rights reserved.
//

#import "WDPersonCenterViewController.h"
#import "WDPageViewController.h"

#import "WDPageTestViewController.h"

@interface WDPersonCenterViewController ()

@property (nonatomic, strong) UIButton *button;

@end

@implementation WDPersonCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.wdNavigationBar.centerButton setTitle:@"个人中心<精简版>" forState:UIControlStateNormal];
    
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.button setTitle:@"点击查看个人页面效果" forState:UIControlStateNormal];
    [self.button setTitleColor:UIColor.blueColor forState:UIControlStateNormal];
    [self.button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.button];
    
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = true;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super  viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = true;
}

- (void)buttonAction {

    NSArray *titleArray = @[@"相册", @"说说" , @"日志"];
    WDPageTestViewController *oneVc  = [WDPageTestViewController new];
    WDPageTestViewController *twoVc  = [WDPageTestViewController new];
    WDPageTestViewController *thirdVc  = [WDPageTestViewController new];
    
    NSArray *viewControllers = @[oneVc,twoVc,thirdVc];
    
    WDPageViewController *controller = [[WDPageViewController alloc] init];
    UIImage *backImage = kTempImageName(@"backItem");
    [controller.topBarView.leftButton setImage:backImage forState:UIControlStateNormal];
    [controller.topBarView.leftButton setTintColor:UIColor.blackColor];
    [controller.topBarView.centerButton setTitle:@"个人中心" forState:UIControlStateNormal];
    [controller.topBarView.rightButton setTitle:@"更多" forState:UIControlStateNormal];
    [controller configWihVcArray:viewControllers titleArray:titleArray headerImage:@"1532095125345.jpg"];
    [self.navigationController pushViewController:controller animated:true];
}

@end
