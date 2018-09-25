//
//  AppleSystemViewController.m
//  iOS-Objc-Demo
//
//  Created by 吴丹 on 2018/9/19.
//  Copyright © 2018 forever.love. All rights reserved.
//

#import "AppleSystemViewController.h"

@interface AppleSystemViewController ()

@property (nonatomic, copy) NSArray *dataArray;
@property (nonatomic, copy) NSArray *controllerArray;

@end

@implementation AppleSystemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self dataInitialization];
    [self setupSubViewsPropertys];
    [self setupSubViewsConstraints];
}

#pragma mark =============== Set up navigation bar style ===============
- (void)setupNavigationBar {
    [super setupNavigationBar];
    [self.wdNavigationBar.centerButton setTitle:@"苹果系统库" forState:UIControlStateNormal];
}

#pragma mark =============== Add controls, set properties ===============
- (void)setupSubViewsPropertys {
    [self.view addSubview:self.tableView];
}

#pragma mark =============== Setting control layout constraints ===============
- (void)setupSubViewsConstraints {
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.mas_equalTo(0);
        make.top.mas_equalTo(self.wdNavigationBar.mas_bottom);
    }];
}

#pragma mark =============== Data initialization ===============
- (void)dataInitialization {
    self.dataArray = @[@"HealthKit----健康信息", ];
    self.controllerArray = @[@"HealthKitViewController", ];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString * const reuserIdentify = @"baseCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuserIdentify];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuserIdentify];
    }
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    
    Class class = NSClassFromString(self.controllerArray[indexPath.row]);
    UIViewController *vc = [[class alloc] init];
    [self.navigationController pushViewController:vc animated:true];
}

@end
