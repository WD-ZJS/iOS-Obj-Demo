//
//  WDBannerViewController.m
//  iOS-Objc-Demo
//
//  Created by 吴丹 on 2018/9/17.
//  Copyright © 2018 forever.love. All rights reserved.
//

#import "WDBannerViewController.h"
#import "WDBannerView.h"

@interface WDBannerViewController ()

@end

@implementation WDBannerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self.wdNavigationBar.centerButton setTitle:@"自定义轮播图" forState:UIControlStateNormal];
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < 7; i++) {
        [array addObject:[NSString stringWithFormat:@"test%d.jpg",i]];
    }
    WDBannerView *view = [[WDBannerView alloc] initLoadLocalBannerWithImageArray:array];
    [self.view addSubview:view];
    view.frame = CGRectMake(0, UIApplication.sharedApplication.statusBarFrame.size.height + 44, kSCREEN_WIDTH, 200);
    
    
    NSMutableArray *array1 = [NSMutableArray array];
    
    [array1 addObject:@"https://ss1.baidu.com/9vo3dSag_xI4khGko9WTAnF6hhy/image/h%3D300/sign=3892481d2c3fb80e13d167d706d02ffb/4034970a304e251facb1a0d4aa86c9177f3e5353.jpg"];
    [array1 addObject:@"https://ss1.baidu.com/-4o3dSag_xI4khGko9WTAnF6hhy/image/h%3D300/sign=5c5f5462a04bd1131bcdb1326aaea488/7af40ad162d9f2d3c3e694fea4ec8a136327cc28.jpg"];
    [array1 addObject:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1537173770489&di=d5f19afd6c48dbcf2e2cf4511d01e2c2&imgtype=0&src=http%3A%2F%2Fh.hiphotos.baidu.com%2Fzhidao%2Fpic%2Fitem%2Fb7fd5266d01609242404d97bd50735fae6cd34a8.jpg"];
    [array1 addObject:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1537173770488&di=b0307cf4992a4178a7ccfe8378240615&imgtype=0&src=http%3A%2F%2Fimg.zcool.cn%2Fcommunity%2F038497757a940710000012e7ea0c6ce.jpg"];
    
    WDBannerView *view1 = [[WDBannerView alloc] initLoadInterBannerWithImageArray:array1];
    [self.view addSubview:view1];
    view1.frame = CGRectMake(0, UIApplication.sharedApplication.statusBarFrame.size.height + 44 + 300, kSCREEN_WIDTH, 200);
    
}
@end
