//
//  Demo1TestViewController.m
//  iOS-Demo
//
//  Created by 吴丹 on 2018/9/5.
//  Copyright © 2018 forever.love. All rights reserved.
//

#import "Demo1TestViewController.h"

@interface Demo1TestViewController ()


@end

@implementation Demo1TestViewController

#pragma mark - LifeCyle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1];
}


#pragma mark - DidReceiveMemoryWarning
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)dealloc {
    NSLog(@"%@-释放了",self.class);
}

#pragma mark - SetupNavigationBar
- (void)setupNavigationBar{

}

#pragma mark - SetupSubviewsUI
- (void)setupSubviews{

}

#pragma mark - SetupSubviewsConstraints
- (void)setupSubviewsConstraints{

}

#pragma mark - Target Methods

#pragma mark - Private Method

#pragma mark - External Delegate

#pragma mark - UITableViewDelegate,UITableViewDataSource

#pragma mark - NetWork Request

#pragma mark - Setter Getter Methods

@end
