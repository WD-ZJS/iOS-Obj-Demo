//
//  WDDropDownViewController.m
//  iOS-Demo
//
//  Created by 吴丹 on 2018/9/7.
//  Copyright © 2018 forever.love. All rights reserved.
//

#import "WDDropDownViewController.h"
#import "DropViewTest-1ViewController.h"
#import "DropViewTest-2ViewController.h"
#import "DropViewTestViewController.h"

#import "WDDropView/WDDropDownView.h"

@interface WDDropDownViewController ()

@end

@implementation WDDropDownViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    [self.wdNavigationBar.centerButton setTitle:@"下拉分类" forState:UIControlStateNormal];
    
    DropViewTest_1ViewController *vc1 = [[DropViewTest_1ViewController alloc] init];
    DropViewTest_2ViewController *vc2 = [[DropViewTest_2ViewController alloc] init];
    DropViewTestViewController *vc3 = [[DropViewTestViewController alloc] init];

    WDDropDownView *test = [[WDDropDownView alloc] init];
    test.titleArray = @[@"排序", @"分类", @"排序"];
    test.controllerArray = @[vc1,vc2, vc3];
    test.controllerHeightArray = @[@(210), @(120), @(300)];
    [self.view addSubview:test];
    
    test.translatesAutoresizingMaskIntoConstraints = false;
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:test attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.wdNavigationBar attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:test attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1 constant:0];
    NSLayoutConstraint *trealing = [NSLayoutConstraint constraintWithItem:test attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1 constant:0];
    NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:test attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:45];
    [self.view addConstraints:@[top,leading,trealing,height]];
}


@end
