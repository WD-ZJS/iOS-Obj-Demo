//
//  WDLodingViewController.m
//  iOS-Objc-Demo
//
//  Created by wudan on 2018/9/29.
//  Copyright © 2018 forever.love. All rights reserved.
//

#import "WDLodingViewController.h"
#import "WDLoadingHUD.h"

@interface WDLodingViewController ()

@property (nonatomic, copy) NSArray<NSString *> *dataArray;

@end

@implementation WDLodingViewController

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
    [self.wdNavigationBar.centerButton setTitle:@"自定义Loding" forState:UIControlStateNormal];
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
    self.dataArray = @[@"显示系统菊花", @"仅文字", @"图上文下", @"图下文上", @"图左文右", @"图右文左", @"循环显示"];
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
    
    switch (indexPath.row) {
        case 0:{
            [[WDLoadingHUD hud] showNormalIndicatorWithStyle:WDLoadingHUDColorStyleDefault];
        }
            break;
        case 1:{
            [[WDLoadingHUD hud] showNormalTitle:@"加载中..." style:WDLoadingHUDColorStyleDefault];
        }
            break;
        case 2:{
            [[WDLoadingHUD hud] showTitle:@"加载中" imageName:@"MBHUD_Success" direction:WDLoadingHUDImageDirectionTop style:WDLoadingHUDColorStyleDefault];
        }
            break;
        case 3:{
            [[WDLoadingHUD hud] showTitle:@"加载中" imageName:@"MBHUD_Success" direction:WDLoadingHUDImageDirectionBottom style:WDLoadingHUDColorStyleDefault];
        }
            break;
        case 4:{
            [[WDLoadingHUD hud] showTitle:@"加载中" imageName:@"MBHUD_Success" direction:WDLoadingHUDImageDirectionLeft style:WDLoadingHUDColorStyleDefault];
        }
            break;
        case 5:{
            [[WDLoadingHUD hud] showTitle:@"加载中" imageName:@"MBHUD_Success" direction:WDLoadingHUDImageDirectionRight style:WDLoadingHUDColorStyleDefault];
        }
            break;
        case 6:{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                 [[WDLoadingHUD hud] showNormalIndicatorWithStyle:WDLoadingHUDColorStyleDefault];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [[WDLoadingHUD hud] showNormalTitle:@"加载中..." style:WDLoadingHUDColorStyleDefault];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [[WDLoadingHUD hud] showTitle:@"加载中" imageName:@"MBHUD_Success" direction:WDLoadingHUDImageDirectionTop style:WDLoadingHUDColorStyleDefault];
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            [[WDLoadingHUD hud] showTitle:@"加载中" imageName:@"MBHUD_Success" direction:WDLoadingHUDImageDirectionBottom style:WDLoadingHUDColorStyleDefault];
                            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                [[WDLoadingHUD hud] showTitle:@"加载中" imageName:@"MBHUD_Success" direction:WDLoadingHUDImageDirectionLeft style:WDLoadingHUDColorStyleDefault];
                                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                    [[WDLoadingHUD hud] showTitle:@"加载中" imageName:@"MBHUD_Success" direction:WDLoadingHUDImageDirectionRight style:WDLoadingHUDColorStyleDefault];
                                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                        [[WDLoadingHUD hud] dismissHUD];
                                    });
                                });
                            });
                        });
                    });
                });
            });
        }
            break;
        default:
            break;
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[WDLoadingHUD hud] dismissHUD];
    });
}

@end
