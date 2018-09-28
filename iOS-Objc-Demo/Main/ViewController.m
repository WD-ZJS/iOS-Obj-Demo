//
//  ViewController.m
//  iOS-Demo
//
//  Created by 吴丹 on 2018/9/5.
//  Copyright © 2018 forever.love. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
/** < 名称数组 > */
@property (nonatomic, copy) NSArray<NSArray<NSString *> *> *dataArray;
/** < 时间数组 > */
@property (nonatomic, copy) NSArray<NSString *> *dateArray;
/** < 控制器数组 > */
@property (nonatomic, copy) NSArray<NSArray<NSString *> *> *controllerArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initializationData];
}

- (void)setupNavigationBar {
    [super setupNavigationBar];
    self.wdNavigationBar.leftButton.hidden = true;
    [self.wdNavigationBar.centerButton setTitle:@"Demo大全" forState:UIControlStateNormal];
}

- (void)setupSubviews {
    [self.view addSubview:self.tableView];
}

- (void)setupSubviewsConstraints {
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.mas_equalTo(0);
        make.top.mas_equalTo(self.wdNavigationBar.mas_bottom);
    }];
}

- (void)initializationData {
    
    self.dataArray = @[@[@"今日头条滑动控件", @"Masonry九宫格布局", @"仿微博个人中心"],
                       @[@"带进度条H5加载"],
                       @[@"仿微信底部弹窗", @"下拉分类", @"侧边栏分类筛选"],
                       @[@"WebSocket"],
                       @[@"瀑布流布局", @"空数据页面封装", @"仿微博个人中心2"],
                       @[@"联系人排序"],
                       @[@"图片选择器"],
                       @[@"自定义轮播图"],
                       @[@"仿QQ音乐页面", @"模态弹窗", @"动画学习"],
                       @[@"苹果系统库"],
                       @[@"打字效果"],
                       @[@"访问联系人", @"本地推送", @"拨打电话", @"发送短信", @"发送邮件"],
                       @[@"个人中心<精简版>"],
                       @[@"下拉框 -- ComBox"]];
    
    self.dateArray = @[@"2018-09-05", @"2018-09-06", @"2018-09-07", @"2018-09-10", @"2018-09-11", @"2018-09-12", @"2018-09-14", @"2018-09-17", @"2018-09-18", @"2018-09-19", @"2018-09-21", @"2018-09-25", @"2018-09-27", @"2018-09-28"];
    
    self.controllerArray = @[@[@"Demo1ViewController", @"Demo2ViewController", @"Demo3ViewController"],
                             @[@"WDWebViewController"],
                             @[@"WDBottomSheetViewController", @"WDDropDownViewController", @"WDSlideCategoryViewController"],
                             @[@"WebSocketViewController"],
                             @[@"WaterfallFlowViewController", @"WDEmptyNoDataViewController", @"JianShuViewController"],
                             @[@"SortContactsController"],
                             @[@"WDPhotoPickerTestViewController"],
                             @[@"WDBannerViewController"],
                             @[@"QQMusicPageViewController", @"WDModalViewController", @"WDAnimationViewController"],
                             @[@"AppleSystemViewController"],
                             @[@"WDPrintViewController"],
                             @[@"WDContactPersonViewController", @"NotificationViewController", @"DailViewController", @"SendMsgViewController", @"SendEmailViewController"],
                             @[@"WDPersonCenterViewController"],
                             @[@"ComBoxViewController"]
                             ];
    
    [self.tableView reloadData];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.dateArray[section];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataArray[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString * const reuserIdentify = @"baseCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuserIdentify];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuserIdentify];
    }
    cell.textLabel.text = self.dataArray[indexPath.section][indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    
    Class class = NSClassFromString(self.controllerArray[indexPath.section][indexPath.row]);
    UIViewController *vc = [[class alloc] init];
    [self.navigationController pushViewController:vc animated:true];
}

@end
