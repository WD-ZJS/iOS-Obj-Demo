//
//  HealthStepCalculatorController.m
//  iOS-Objc-Demo
//
//  Created by 吴丹 on 2018/9/19.
//  Copyright © 2018 forever.love. All rights reserved.
//

#import "HealthStepCalculatorController.h"
#import "HealthKitManager.h"

@interface HealthStepCalculatorController ()

@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) UIButton *stepButton;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) dispatch_source_t gcdTimer;

@end

@implementation HealthStepCalculatorController

static int gcdIdx = 0;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIApplication *app = [UIApplication sharedApplication];
    
    __block UIBackgroundTaskIdentifier bgTask;
    
    bgTask = [app beginBackgroundTaskWithExpirationHandler:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            if (bgTask != UIBackgroundTaskInvalid) {
                bgTask = UIBackgroundTaskInvalid;
            }
        });
    }];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            if (bgTask != UIBackgroundTaskInvalid) {
                bgTask = UIBackgroundTaskInvalid;
            }
        });
    });
    
    
    [self dataInitialization];
}

- (void)dataInitialization {
    
    self.view.backgroundColor = UIColor.orangeColor;
    
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:30];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = UIColor.whiteColor;
    label.numberOfLines = 0;
    [self.view addSubview:label];
    label.text = @"已经计步：0步";
    
    UILabel *time = [[UILabel alloc] init];
    time.font = [UIFont systemFontOfSize:30];
    time.textAlignment = NSTextAlignmentCenter;
    time.textColor = UIColor.whiteColor;
    time.numberOfLines = 0;
    [self.view addSubview:time];
    time.text = @"00:00:00";
    self.timeLabel = time;
    
    self.stepButton = [[UIButton alloc] init];
    [self.stepButton setTitle:@"结束计算步数" forState:UIControlStateNormal];
    self.stepButton.backgroundColor = [UIColor colorWithRed:95.0/255 green:171.0/255 blue:231.0/255 alpha:1];
    [self.stepButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    self.stepButton.layer.cornerRadius = 50;
    self.stepButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.stepButton addTarget:self action:@selector(endAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.stepButton];
    
    [self.stepButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(0);
        make.height.width.mas_equalTo(100);
    }];
    
    [time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.stepButton.mas_top).mas_offset(-100);
        make.centerX.mas_equalTo(0);
    }];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.stepButton.mas_bottom).mas_offset(100);
        make.centerX.mas_equalTo(0);
    }];
    
    [[HealthKitManager mamager] requsetCalculationStepWithStepBlock:^(int stepCount, int distance) {
        dispatch_async(dispatch_get_main_queue(), ^{
            label.text = [NSString stringWithFormat:@"已经计步：%d步\n\n相当于%dm",stepCount, distance];
        });
    }];
    
    [self updataTime];
}


#pragma mark =============== 开启计时器 ===============
- (void)updataTime {
    
    _gcdTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(0, 0));
    dispatch_source_set_timer(_gcdTimer, DISPATCH_TIME_NOW, 2.0 * NSEC_PER_SEC, 0.0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(_gcdTimer, ^{
        gcdIdx++;
        /// 回到主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            self.timeLabel.text = [NSString stringWithFormat:@"%02d:%02d:%02d",gcdIdx/60/60, gcdIdx/60, gcdIdx%60];
        });
    });
    // 启动任务，GCD计时器创建后需要手动启动
    dispatch_resume(_gcdTimer);
}

- (void)endAction {
    UIAlertController *alter = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"是否结束计步？" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *actionSure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[HealthKitManager mamager] endCalculationStep];
        // 终止定时器
        dispatch_suspend(self->_gcdTimer);
        gcdIdx = 0;
        [self dismissViewControllerAnimated:true completion:nil];
    }];
    
    UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        [alter dismissViewControllerAnimated:true completion:nil];
    }];
    
    [alter addAction:actionSure];
    [alter addAction:actionCancel];
    [self presentViewController:alter animated:true completion:nil];
}

@end
