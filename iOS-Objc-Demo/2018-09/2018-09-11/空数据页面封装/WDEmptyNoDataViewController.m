//
//  WDEmptyNoDataViewController.m
//  iOS-Objc-Demo
//
//  Created by 吴丹 on 2018/9/11.
//  Copyright © 2018 forever.love. All rights reserved.
//

#import "WDEmptyNoDataViewController.h"
#import "UIScrollView+WD_NoData.h"
// 自定义页面
#import "WDTestEmptyView.h"

@interface WDEmptyNoDataViewController ()

@property (nonatomic, assign) NSInteger count;

@end

@implementation WDEmptyNoDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.count = 0;
}

- (void)setupNavigationBar {
    [super setupNavigationBar];
    [self.wdNavigationBar.centerButton setTitle:@"TableView无数据" forState:UIControlStateNormal];
    [self.wdNavigationBar.rightButton setTitle:@"清空" forState:UIControlStateNormal];
    [self.wdNavigationBar.rightTwoButton setTitle:@"添加" forState:UIControlStateNormal];
    
    kWeakSelf(self)
    self.wdNavigationBar.rightButtonBlock = ^{
        weakself.count = 0;
        [weakself.tableView reloadData];
    };
    
    self.wdNavigationBar.rightTwoButtonBlock = ^{
        weakself.count = 1;
        [weakself.tableView reloadData];
    };
}

#pragma mark - SetupSubviewsUI
- (void)setupSubviews{
    WDTestEmptyView *view = [NSBundle.mainBundle loadNibNamed:@"WDTestEmptyView" owner:self options:nil].firstObject;
    self.tableView.noDataView = view;
    [self.view addSubview:self.tableView];
}


#pragma mark - SetupSubviewsConstraints
- (void)setupSubviewsConstraints{
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.wdNavigationBar.mas_bottom);
        make.leading.trailing.bottom.mas_equalTo(self.view);
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString * const reuserIdentify = @"baseCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuserIdentify];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuserIdentify];
    }
    cell.textLabel.text = @"有数据了";
    return cell;
}

@end
