//
//  SendMsgViewController.m
//  iOS-Objc-Demo
//
//  Created by wudan on 2018/9/25.
//  Copyright © 2018年 forever.love. All rights reserved.
//

#import "SendMsgViewController.h"
#import <MessageUI/MessageUI.h>

@interface SendMsgViewController ()<MFMessageComposeViewControllerDelegate>

@property (nonatomic, strong) UIButton *dailButton;
@property (nonatomic, strong) UITextField *numTextField;
@property (nonatomic, strong) UITextField *contentTextField;

@end

@implementation SendMsgViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (void)setupNavigationBar {
    [super setupNavigationBar];
    [self.wdNavigationBar.centerButton setTitle:@"系统发送短信" forState:UIControlStateNormal];
}

- (void)setupSubviews {
    self.dailButton = [[UIButton alloc] init];
    [self.dailButton setTitle:@"点击开始发送" forState:UIControlStateNormal];
    [self.dailButton setTitleColor:UIColor.blueColor forState:UIControlStateNormal];
    [self.dailButton addTarget:self action:@selector(notificationAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.dailButton];
    
    self.numTextField = [[UITextField alloc] init];
    self.numTextField.placeholder = @"请输入号码";
    self.numTextField.keyboardType = UIKeyboardTypePhonePad;
    self.numTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.numTextField.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.numTextField];
    
    self.contentTextField = [[UITextField alloc] init];
    self.contentTextField.placeholder = @"请输入内容";
    self.contentTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.contentTextField.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.contentTextField];
}

- (void)setupSubviewsConstraints {
    
    [self.contentTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.view);
        make.leading.trailing.mas_equalTo(self.view).inset(100);
        make.height.mas_equalTo(45);
    }];
    
    [self.numTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.contentTextField.mas_top).mas_offset(-15);
        make.leading.trailing.mas_equalTo(self.view).inset(100);
        make.height.mas_equalTo(45);
    }];
    
    [self.dailButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.contentTextField.mas_bottom).mas_offset(15);
    }];
}

- (void)notificationAction:(id)sender {
    if (self.numTextField.text.length != 0 && self.contentTextField.text.length != 0) {
        if ([MFMessageComposeViewController canSendText]) {
            MFMessageComposeViewController *messageVC = [[MFMessageComposeViewController alloc] init];
            messageVC.recipients = @[self.numTextField.text]; //需要发送的手机号数组
            messageVC.body = self.contentTextField.text;
            messageVC.messageComposeDelegate = self; //指定代理
            [self presentViewController:messageVC animated:YES completion:nil];
        } else {
            [self showHUDWithContent:@"设备不支持短信功能"];
        }
        
    } else if (self.numTextField.text.length == 0){
        [self showHUDWithContent:@"请输入手机号"];
    } else {
        [self showHUDWithContent:@"请输入内容"];
    }
}

#pragma mark =============== MFMessageComposeViewControllerDelegate ===============
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
    [controller dismissViewControllerAnimated:true completion:nil];
    if (result == MessageComposeResultFailed) {
        [self showHUDWithContent:@"发送失败"];
    } else if (result == MessageComposeResultCancelled) {
        [self showHUDWithContent:@"发送被取消"];
    } else {
        [self showHUDWithContent:@"发送成功"];
    }
}

- (void)showHUDWithContent:(NSString *)content {
    UIAlertController *alter = [UIAlertController alertControllerWithTitle:@"温馨提示" message:content preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController:alter animated:true completion:nil];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [alter dismissViewControllerAnimated:true completion:nil];
    });
}

@end
