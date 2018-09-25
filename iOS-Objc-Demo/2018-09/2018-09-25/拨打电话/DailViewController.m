//
//  DailViewController.m
//  iOS-Objc-Demo
//
//  Created by wudan on 2018/9/25.
//  Copyright © 2018年 forever.love. All rights reserved.
//

#import "DailViewController.h"

@interface DailViewController ()

@property (nonatomic, strong) UIButton *dailButton;
@property (nonatomic, strong) UITextField *numTextField;

@end

@implementation DailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (void)setupNavigationBar {
    [super setupNavigationBar];
    [self.wdNavigationBar.centerButton setTitle:@"系统拨号" forState:UIControlStateNormal];
}

- (void)setupSubviews {
    self.dailButton = [[UIButton alloc] init];
    [self.dailButton setTitle:@"点击开始拨号" forState:UIControlStateNormal];
    [self.dailButton setTitleColor:UIColor.blueColor forState:UIControlStateNormal];
    [self.dailButton addTarget:self action:@selector(notificationAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.dailButton];
    
    self.numTextField = [[UITextField alloc] init];
    self.numTextField.placeholder = @"请输入号码";
    self.numTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.numTextField.keyboardType = UIKeyboardTypePhonePad;
    self.numTextField.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.numTextField];
}

- (void)setupSubviewsConstraints {
    [self.numTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view.mas_centerY).mas_offset(-15);
        make.leading.trailing.mas_equalTo(self.view).inset(100);
        make.height.mas_equalTo(45);
    }];
    
    [self.dailButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view.mas_centerY).mas_offset(15);
    }];
}

- (void)notificationAction:(id)sender {
    if (self.numTextField.text.length != 0) {
        // 方式一
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",self.numTextField.text]]];
        // 方式二
//        UIWebView * callWebview = [[UIWebView alloc] init];
//        [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",self.numTextField.text]]]];
//        [self.view addSubview:callWebview];

    } else {
        UIAlertController *alter = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请输入号码" preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alter animated:true completion:nil];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [alter dismissViewControllerAnimated:true completion:nil];
        });
    }
}

@end
