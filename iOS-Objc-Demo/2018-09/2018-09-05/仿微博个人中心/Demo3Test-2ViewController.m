//
//  Demo3Test-2ViewController.m
//  iOS-Demo
//
//  Created by 吴丹 on 2018/9/5.
//  Copyright © 2018 forever.love. All rights reserved.
//

#import "Demo3Test-2ViewController.h"

@interface Demo3Test_2ViewController ()<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation Demo3Test_2ViewController

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.backgroundColor = UIColor.groupTableViewBackgroundColor;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.estimatedRowHeight = 65.f;
        _tableView.tableFooterView = UIView.new;
    }
    return _tableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 100;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString * const reuserIdentify = @"baseCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuserIdentify];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuserIdentify];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"默认文字-------%ld",(long)indexPath.section + 1];
    return cell;
}

#pragma mark - LifeCyle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    self.wd_scrollView = self.tableView;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}

- (void)wd_scrollViewDidScroll:(UIScrollView *)scrollView {
    [super wd_scrollViewDidScroll:scrollView];
}

- (void)scrollToTop {
    [self.tableView setContentOffset:CGPointZero animated:false];
}

@end
