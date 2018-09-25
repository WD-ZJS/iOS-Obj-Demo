//
//  WebSocketViewController.m
//  iOS-Objc-Demo
//
//  Created by 吴丹 on 2018/9/10.
//  Copyright © 2018 forever.love. All rights reserved.
//

#import "WebSocketViewController.h"
#import "WDWebSoketManager.h"

@interface WebSocketViewController ()<WDWebSoketManagerDelegate>

@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, copy) NSString *tempText;

@end

@implementation WebSocketViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tempText = @"";
    
    [self.wdNavigationBar.centerButton setTitle:@"WebSocet" forState:UIControlStateNormal];
    
    [self.wdNavigationBar.rightButton setTitle:@"发送" forState:UIControlStateNormal];
    self.wdNavigationBar.rightButtonBlock = ^{
        NSInteger random = arc4random() % 999;
        NSString *tempStr = [NSString stringWithFormat:@"往服务器发送的测试消息:%ld",random];
        [[WDWebSoketManager manager] senderMessager:tempStr];
    };
    
    [self.wdNavigationBar.rightTwoButton setTitle:@"停止" forState:UIControlStateNormal];
    self.wdNavigationBar.rightTwoButtonBlock = ^{
        [[WDWebSoketManager manager] closeContat];
    };
    
    [[WDWebSoketManager manager] contactToSeverWithUrlAddress:@"ws://118.31.12.178:80/websocket/2"];
    [[WDWebSoketManager manager] setDelegate:self];
    
    self.textView = [[UITextView alloc] init];
    self.textView.editable = false;
    [self.view addSubview:self.textView];
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.wdNavigationBar.mas_bottom);
        make.leading.trailing.bottom.mas_equalTo(self.view);
    }];
}

- (void)getMassageFromSeverWithInfo:(NSString *)info {
    self.tempText = [NSString stringWithFormat:@"%@%@\n",self.tempText,info];
    self.textView.text = self.tempText;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [[WDWebSoketManager manager] closeContat];
}

@end
