//
//  SendEmailViewController.m
//  iOS-Objc-Demo
//
//  Created by wudan on 2018/9/25.
//  Copyright © 2018年 forever.love. All rights reserved.
//

#import "SendEmailViewController.h"
#import <MessageUI/MessageUI.h>

@interface SendEmailViewController () <MFMailComposeViewControllerDelegate>
/** < 收件人 > */
@property (nonatomic, strong) UITextField *numTextField;
/** < 抄送人 > */
@property (nonatomic, strong) UITextField *cpTextField;
/** < 密送人 > */
@property (nonatomic, strong) UITextField *carrierTextFiled;
/** < 主题> */
@property (nonatomic, strong) UITextField *themeTextField;
/** < 内容 > */
@property (nonatomic, strong) UITextField *contentTextField;
/** < 拨号按钮 > */
@property (nonatomic, strong) UIButton *dailButton;
@end

@implementation SendEmailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (void)setupNavigationBar {
    [super setupNavigationBar];
    [self.wdNavigationBar.centerButton setTitle:@"系统发送邮件" forState:UIControlStateNormal];
}

- (void)setupSubviews {
    
    self.numTextField = [[UITextField alloc] init];
    self.numTextField.placeholder = @"请输入收件人地址";
    self.numTextField.keyboardType = UIKeyboardTypeEmailAddress;
    self.numTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.numTextField.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.numTextField];
    
    self.cpTextField = [[UITextField alloc] init];
    self.cpTextField.placeholder = @"请输入抄送人地址";
    self.cpTextField.keyboardType = UIKeyboardTypeEmailAddress;
    self.cpTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.cpTextField.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.cpTextField];
    
    self.carrierTextFiled = [[UITextField alloc] init];
    self.carrierTextFiled.placeholder = @"请输入密送人地址";
    self.carrierTextFiled.keyboardType = UIKeyboardTypeEmailAddress;
    self.carrierTextFiled.borderStyle = UITextBorderStyleRoundedRect;
    self.carrierTextFiled.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.carrierTextFiled];
    
    self.themeTextField = [[UITextField alloc] init];
    self.themeTextField.placeholder = @"请输入主题";
    self.themeTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.themeTextField.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.themeTextField];
    
    self.contentTextField = [[UITextField alloc] init];
    self.contentTextField.placeholder = @"请输入内容";
    self.contentTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.contentTextField.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.contentTextField];
    
    self.dailButton = [[UIButton alloc] init];
    [self.dailButton setTitle:@"点击开始发送" forState:UIControlStateNormal];
    [self.dailButton setTitleColor:UIColor.blueColor forState:UIControlStateNormal];
    [self.dailButton addTarget:self action:@selector(notificationAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.dailButton];
}

- (void)setupSubviewsConstraints {
    
    [self.numTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.wdNavigationBar.mas_bottom).mas_offset(15);
        make.leading.trailing.mas_equalTo(self.view).inset(100);
        make.height.mas_equalTo(45);
    }];
    
    [self.cpTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.numTextField.mas_bottom).mas_offset(15);
        make.leading.trailing.mas_equalTo(self.view).inset(100);
        make.height.mas_equalTo(45);
    }];
    
    [self.carrierTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.cpTextField.mas_bottom).mas_offset(15);
        make.leading.trailing.mas_equalTo(self.view).inset(100);
        make.height.mas_equalTo(45);
    }];
    
    [self.themeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.carrierTextFiled.mas_bottom).mas_offset(15);
        make.leading.trailing.mas_equalTo(self.view).inset(100);
        make.height.mas_equalTo(45);
    }];
    
    [self.contentTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.themeTextField.mas_bottom).mas_offset(15);
        make.leading.trailing.mas_equalTo(self.view).inset(100);
        make.height.mas_equalTo(45);
    }];
    
    [self.dailButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentTextField.mas_bottom).mas_offset(15);
        make.centerX.mas_equalTo(self.view);
    }];
}

- (void)notificationAction:(id)sender {
    if (self.numTextField.text.length != 0 && self.contentTextField.text.length != 0) {
        if ([MFMailComposeViewController canSendMail]) {
            [self sendEmailAction];
        }else{
            [self showHUDWithContent:@"设备未开启邮件服务"];
        }
    } else if (self.numTextField.text.length == 0){
        [self showHUDWithContent:@"请输入收件人地址"];
    } else {
        [self showHUDWithContent:@"请输入内容"];
    }
}

-(void)sendEmailAction{
    // 创建邮件发送界面
    MFMailComposeViewController *mailCompose = [[MFMailComposeViewController alloc] init];
    // 设置邮件代理
    [mailCompose setMailComposeDelegate:self];
    // 设置收件人
    [mailCompose setToRecipients:@[self.numTextField.text]];
    // 设置抄送人
    [mailCompose setCcRecipients:@[self.cpTextField.text]];
    // 设置密送人
    [mailCompose setBccRecipients:@[self.carrierTextFiled.text]];
    // 设置邮件主题
    [mailCompose setSubject:self.themeTextField.text];
    //设置邮件的正文内容
    NSString *emailContent = self.contentTextField.text;
    // 是否为HTML格式
    [mailCompose setMessageBody:emailContent isHTML:NO];
    // 如使用HTML格式，则为以下代码
    // [mailCompose setMessageBody:@"<html><body><p>Hello</p><p>World！</p></body></html>" isHTML:YES];
    //添加附件
    UIImage *image = [UIImage imageNamed:@"AppIcon"];
    NSData *imageData = UIImagePNGRepresentation(image);
    [mailCompose addAttachmentData:imageData mimeType:@"" fileName:@"AppIcon.png"];
    // 弹出邮件发送视图
    [self presentViewController:mailCompose animated:YES completion:nil];
}

#pragma mark - MFMailComposeViewControllerDelegate的代理方法：
-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    // 关闭邮件发送视图
    [controller dismissViewControllerAnimated:YES completion:nil];
    
    switch (result) {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail send canceled: 用户取消编辑");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved: 用户保存邮件");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent: 用户点击发送");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail send errored: %@ : 用户尝试保存或发送邮件失败", [error localizedDescription]);
            break;
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
