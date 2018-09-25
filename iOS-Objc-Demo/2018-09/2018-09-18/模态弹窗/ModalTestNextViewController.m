//
//  ModalTestNextViewController.m
//  iOS-Objc-Demo
//
//  Created by 吴丹 on 2018/9/18.
//  Copyright © 2018 forever.love. All rights reserved.
//

#import "ModalTestNextViewController.h"

@interface ModalTestNextViewController ()

@end

@implementation ModalTestNextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"测试第二页视图";
    
    self.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256)/255.5
                                                green:arc4random_uniform(256)/255.5
                                                 blue:arc4random_uniform(256)/255.5
                                                alpha:1];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
