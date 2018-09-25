//
//  NotificationViewController.m
//  iOS-Objc-Demo
//
//  Created by wudan on 2018/9/25.
//  Copyright © 2018年 forever.love. All rights reserved.
//

#import "NotificationViewController.h"

@interface NotificationViewController ()

@property (nonatomic, strong) UIButton *notification;

@end

@implementation NotificationViewController
/**
 fireDate：启动时间
 timeZone：启动时间参考的时区
 repeatInterval：重复推送时间（NSCalendarUnit类型），0代表不重复
 repeatCalendar：重复推送时间（NSCalendar类型）
 alertBody：通知内容
 alertAction：解锁滑动时的事件
 alertLaunchImage：启动图片，设置此字段点击通知时会显示该图片
 alertTitle：通知标题，适用iOS8.2之后
 applicationIconBadgeNumber：收到通知时App icon的角标
 soundName：推送是带的声音提醒，设置默认的字段为UILocalNotificationDefaultSoundName
 userInfo：发送通知时附加的内容
 category：此属性和注册通知类型时有关联，（有兴趣的同学自己了解，不详细叙述）适用iOS8.0之后
 
 region：带有定位的推送相关属性，具体使用见下面【带有定位的本地推送】适用iOS8.0之后
 regionTriggersOnce：带有定位的推送相关属性，具体使用见下面【带有定位的本地推送】适用iOS8.0之后
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (void)setupNavigationBar {
    [super setupNavigationBar];
    [self.wdNavigationBar.centerButton setTitle:@"本地推送" forState:UIControlStateNormal];
}

- (void)setupSubviews {
    self.notification = [[UIButton alloc] init];
    [self.notification setTitle:@"点击开始推送" forState:UIControlStateNormal];
    [self.notification setTitleColor:UIColor.blueColor forState:UIControlStateNormal];
    [self.notification addTarget:self action:@selector(notificationAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.notification];
}

- (void)setupSubviewsConstraints {
    [self.notification mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
    }];
}

- (void)notificationAction:(id)sender {
    // 1.创建通知
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    // 2.设置通知的必选参数
    // 设置通知显示的内容
    localNotification.alertBody = @"本地通知测试";
    // 设置通知的发送时间,单位秒
    localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:10];
    //解锁滑动时的事件
    localNotification.alertAction = @"别磨蹭了!";
    //收到通知时App icon的角标
    localNotification.applicationIconBadgeNumber = 1;
    //推送是带的声音提醒，设置默认的字段为UILocalNotificationDefaultSoundName
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    // 3.发送通知(🐽 : 根据项目需要使用)
    // 方式一: 根据通知的发送时间(fireDate)发送通知
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    
    // 方式二: 立即发送通知
     [[UIApplication sharedApplication] presentLocalNotificationNow:localNotification];
}

@end
