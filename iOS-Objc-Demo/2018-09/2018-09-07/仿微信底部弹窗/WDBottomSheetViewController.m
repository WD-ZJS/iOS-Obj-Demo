//
//  WDBottomSheetViewController.m
//  iOS-Demo
//
//  Created by 吴丹 on 2018/9/7.
//  Copyright © 2018 forever.love. All rights reserved.
//

#import "WDBottomSheetViewController.h"
#import "WDActionSheet.h"

@interface WDBottomSheetViewController ()<WDActionSheetDelegate>

@end

@implementation WDBottomSheetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    [self.wdNavigationBar.centerButton setTitle:@"仿微信底部弹窗" forState:UIControlStateNormal];
    
    UIButton * noCancelButton = [[UIButton alloc] init];
    [noCancelButton setTitle:@"无取消按钮" forState:UIControlStateNormal];
    [noCancelButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    noCancelButton.backgroundColor = UIColor.blueColor;
    [noCancelButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:noCancelButton];

    CGFloat W = UIScreen.mainScreen.bounds.size.width / 2;
    CGFloat H = UIScreen.mainScreen.bounds.size.width / 2 / 4;
    
    noCancelButton.translatesAutoresizingMaskIntoConstraints = false;
    NSLayoutConstraint *no_width = [NSLayoutConstraint constraintWithItem:noCancelButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1 constant:W];
    NSLayoutConstraint *no_height = [NSLayoutConstraint constraintWithItem:noCancelButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:H];
    NSLayoutConstraint *no_bottom = [NSLayoutConstraint constraintWithItem:noCancelButton attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1 constant:-10];
    NSLayoutConstraint *no_centerX = [NSLayoutConstraint constraintWithItem:noCancelButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    [self.view addConstraints:@[no_width,no_height,no_bottom,no_centerX]];
    
    UIButton * cancelButton = [[UIButton alloc] init];
    [cancelButton setTitle:@"有取消按钮" forState:UIControlStateNormal];
    [cancelButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    cancelButton.backgroundColor = UIColor.blueColor;
    [cancelButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelButton];
    
    cancelButton.translatesAutoresizingMaskIntoConstraints = false;
    NSLayoutConstraint *cancel_width = [NSLayoutConstraint constraintWithItem:cancelButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:noCancelButton attribute:NSLayoutAttributeWidth multiplier:1 constant:0];
    NSLayoutConstraint *cancel_height = [NSLayoutConstraint constraintWithItem:cancelButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:noCancelButton attribute:NSLayoutAttributeHeight multiplier:1 constant:0];
    NSLayoutConstraint *cancel_top = [NSLayoutConstraint constraintWithItem:cancelButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1 constant:10];
    NSLayoutConstraint *cancel_centerX = [NSLayoutConstraint constraintWithItem:cancelButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    [self.view addConstraints:@[cancel_width,cancel_height,cancel_top,cancel_centerX]];
}

- (void)buttonAction:(UIButton *)sender {
    if ([sender.titleLabel.text isEqualToString:@"无取消按钮"]) {
        // cancelButtonTitle可以直接输入空字符串或者nil
        [[WDActionSheet shareInstances] setUIWithTitleArray:@[@"拍照",@"打开相册"] cancelButtonTitle:@"" selectDelegate:self];
    } else {
        [[WDActionSheet shareInstances] setUIWithTitleArray:@[@"拍照",@"打开相册"] cancelButtonTitle:@"取消" selectDelegate:self];
    }
}

#pragma mark =============== WDActionSheetDelegate ===============
- (void)selectedIndex:(NSInteger)index {
    
}

@end
