//
//  ComBoxViewController.m
//  iOS-Objc-Demo
//
//  Created by wudan on 2018/9/28.
//  Copyright © 2018 forever.love. All rights reserved.
//

#import "ComBoxViewController.h"
#import "WDComboBoxControl.h"

@interface ComBoxViewController () <WDComboBoxControlDataSource, WDComboBoxControlDelegate>

@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UIButton *button2;
@property (nonatomic, strong) UIButton *lastButton;

@end

@implementation ComBoxViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button = [[UIButton alloc] init];
    [button setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonShow:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    button.layer.borderColor = UIColor.lightGrayColor.CGColor;
    button.layer.borderWidth = 0.5;
    [button setTitle:@"按钮" forState:UIControlStateNormal];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.wdNavigationBar.mas_bottom);
        make.width.mas_equalTo(300);

    }];
    self.button = button;
    
    
    UIButton *button2 = [[UIButton alloc] init];
    [button2 setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(buttonShow:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    button2.layer.borderColor = UIColor.lightGrayColor.CGColor;
    button2.layer.borderWidth = 0.5;
    [button2 setTitle:@"按钮2" forState:UIControlStateNormal];
    button2.bounds = CGRectMake(0, 0, 300, 50);
    button2.center = self.view.center;
    self.button2 = button2;
}

- (void)buttonShow:(UIButton *)sender {
    self.lastButton = sender;

    [self.wdNavigationBar.centerButton setTitle:@"自定义下拉框" forState:UIControlStateNormal];
    WDComboBoxControl *view = [[WDComboBoxControl alloc] initViewWithMaxHeight:400 fromView:sender showDirection:WDComboBoxControlDirectionBottom];
    view.dataSource = self;
    view.delegate = self;
    view.backgroundButton.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    [view showInView];
}

#pragma mark =============== WDComBoxControlDataSource ===============
- (NSArray<NSString *> *)titleOfSection {
    return [self.lastButton isEqual:self.button2] ? @[@"安徽省", @"浙江省", @"江苏省", @"安徽省"] : @[@"湖北省", @"湖南省", @"福建省"];
}

- (NSArray<NSArray<NSString *> *> *)dataSourceOfColunm {
    return [self.lastButton isEqual:self.button2] ? @[@[@"合肥", @"芜湖", @"安庆"],
                                                      @[@"南京", @"苏州", @"无锡"],
                                                      @[@"杭州", @"宁波", @"温州"]] : @[@[@"合肥", @"芜湖", @"安庆"],
                                                                                    @[@"南京", @"苏州", @"无锡"],
                                                                                    @[@"杭州", @"宁波", @"温州"]];
                                                                            
}

#pragma mark =============== WDComBoxControlDelegate ===============
- (void)selectedAtIndexPath:(NSIndexPath *)indexPath resultTitle:(NSString *)title fromSourceView:(UIView *)sourceView {
    UIButton *sender = (UIButton *)sourceView;
    [sender setTitle:title forState:UIControlStateNormal];
}

@end
