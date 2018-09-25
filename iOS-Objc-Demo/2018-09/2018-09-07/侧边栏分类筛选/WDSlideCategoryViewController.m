//
//  WDSlideCategoryViewController.m
//  iOS-Demo
//
//  Created by 吴丹 on 2018/9/7.
//  Copyright © 2018 forever.love. All rights reserved.
//

#import "WDSlideCategoryViewController.h"
#import "SliderCategoryView.h"

@interface WDSlideCategoryViewController ()

@end

@implementation WDSlideCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self.wdNavigationBar.centerButton setTitle:@"分类侧边栏" forState:UIControlStateNormal];
    
    UIButton *b = [[UIButton alloc] init];
    [b setTitle:@"打开" forState:UIControlStateNormal];
    [b setTitleColor:UIColor.redColor forState:UIControlStateNormal];
    b.backgroundColor = UIColor.lightGrayColor;
    [b addTarget:self action:@selector(openSlider:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:b];
    
    [b mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
        make.width.mas_equalTo(Screen_Width/2);
        make.height.mas_equalTo(b.mas_width).multipliedBy(0.3);
    }];
}

- (void)openSlider:(id)sender {
    SliderCategoryView *view = [[SliderCategoryView alloc] init];
    [view showView];
}


@end
