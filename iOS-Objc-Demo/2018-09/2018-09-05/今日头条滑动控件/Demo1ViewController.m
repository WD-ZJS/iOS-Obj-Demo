//
//  Demo1ViewController.m
//  iOS-Demo
//
//  Created by 吴丹 on 2018/9/5.
//  Copyright © 2018 forever.love. All rights reserved.
//

#import "Demo1ViewController.h"
#import "WDTabLayout.h"
#import "Demo1TestViewController.h"

@interface Demo1ViewController ()

@property (nonatomic, strong) WDTabLayout *tabLayout;


@end

@implementation Demo1ViewController

#pragma mark - LifeCyle
- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - DidReceiveMemoryWarning
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)dealloc {
    NSLog(@"%@-释放了",self.class);
}

#pragma mark - SetupNavigationBar
- (void)setupNavigationBar{
    [super setupNavigationBar];
    [self.wdNavigationBar.centerButton setTitle:@"今日头条滑动控件" forState:UIControlStateNormal];
}

#pragma mark - SetupSubviewsUI
- (void)setupSubviews{
    NSMutableArray *vcArray = [NSMutableArray array];
    for (int i=0; i<6; i++) {
        Demo1TestViewController *vc = [[Demo1TestViewController alloc] init];
        [vcArray addObject:vc];
    }
    
    self.tabLayout = [[WDTabLayout alloc] initWithShowStyle:WDTabLayoutStyle_buttomIndicate
                                                 titleArray:@[@"示例1",@"示例2",@"示例3",@"示例4",@"示例5",@"示例6"]
                                            viewControllers:vcArray
                                            backgroundColor:UIColor.whiteColor
                                              indicateColor:UIColor.orangeColor
                                                normalColor:UIColor.lightGrayColor
                                              selectedColor:UIColor.redColor
                                                  titleSize:18
                                             indicateHeight:2];
    [self.view addSubview:self.tabLayout];
}

#pragma mark - SetupSubviewsConstraints
- (void)setupSubviewsConstraints{
    [self.tabLayout mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.mas_equalTo(0);
        make.top.mas_equalTo(self.wdNavigationBar.mas_bottom);
    }];
}

#pragma mark - Target Methods

#pragma mark - Private Method

#pragma mark - External Delegate

#pragma mark - UITableViewDelegate,UITableViewDataSource

#pragma mark - NetWork Request

#pragma mark - Setter Getter Methods

@end
