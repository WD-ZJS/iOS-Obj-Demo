//
//  HealthKitViewController.m
//  iOS-Objc-Demo
//
//  Created by 吴丹 on 2018/9/19.
//  Copyright © 2018 forever.love. All rights reserved.
//

#import "HealthKitViewController.h"
#import "HealthKitManager.h"
#import "HealthStepCalculatorController.h"

@interface HealthKitViewController ()

@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, weak) NSTimer *timer;
@property (nonatomic, strong) UIButton *stepButton;

@end

@implementation HealthKitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:30];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = UIColor.blackColor;
    [self.view addSubview:label];
    label.text = @"正在获取步数";
    
    self.stepButton = [[UIButton alloc] init];
    [self.stepButton setTitle:@"开始计算步数" forState:UIControlStateNormal];
    self.stepButton.backgroundColor = UIColor.orangeColor;
    [self.stepButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    self.stepButton.layer.cornerRadius = 50;
    self.stepButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.stepButton addTarget:self action:@selector(startAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.stepButton];
    
    [self.stepButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(0);
        make.height.width.mas_equalTo(100);
    }];
    
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.stepButton.mas_bottom).mas_offset(100);
        make.centerX.mas_equalTo(0);
    }];
    
    
    self.textLabel = label;
    
    [self startTimer];
}

- (void)startAction {
    HealthStepCalculatorController *vc = [[HealthStepCalculatorController alloc] init];
    [self presentViewController:vc animated:true completion:nil];
}

- (void)dealloc {
    [self stopTimer];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self stopTimer];
}

#pragma mark =============== 开启定时器 ===============
- (void)startTimer {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(updataLabel) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

#pragma mark =============== 关闭定时 ===============
- (void)stopTimer {
    [self.timer invalidate];
    self.timer = nil;
}

- (void)updataLabel {
    
    [[HealthKitManager mamager] requsetStepInfoWithStepBlock:^(int stepNum) {
        self.textLabel.text = [NSString stringWithFormat:@"当前步数为：%d",stepNum];
    }];
}

#pragma mark =============== Set up navigation bar style ===============
- (void)setupNavigationBar {
    [super setupNavigationBar];
    [self.wdNavigationBar.centerButton setTitle:@"HealthKit" forState:UIControlStateNormal];
}

@end
