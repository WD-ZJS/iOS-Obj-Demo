//
//  WebSocketViewController.m
//  iOS-Objc-Demo
//
//  Created by 吴丹 on 2018/9/10.
//  Copyright © 2018 forever.love. All rights reserved.
//

#import "WebSocketViewController.h"
#import "SocketRocketUtility.h"

@interface WebSocketViewController ()

@end

@implementation WebSocketViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.wdNavigationBar.centerButton setTitle:@"WebSocet" forState:UIControlStateNormal];
    
    [[SocketRocketUtility instance] SRWebSocketOpenWithURLString:@"ws://118.31.12.178:80/websocket/2"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SRWebSocketDidOpen) name:kWebSocketDidOpenNote object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SRWebSocketDidReceiveMsg:) name:kWebSocketdidReceiveMessageNote object:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [[SocketRocketUtility instance] sendData:@"123123"];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // 页面消失 关闭
    [[SocketRocketUtility instance] SRWebSocketClose];
}

- (void)SRWebSocketDidOpen {
    NSLog(@"开启成功");
}

- (void)SRWebSocketDidReceiveMsg:(NSNotification *)note {
    //收到服务端发送过来的消息
    NSString * message = note.object;
    NSLog(@"服务器发过来的信息：%@",message);
}

@end
