//
//  DropViewTest-03ViewController.m
//  iOS-Demo
//
//  Created by 吴丹 on 2018/9/7.
//  Copyright © 2018 forever.love. All rights reserved.
//

#import "DropViewTestViewController.h"

@interface DropViewTestViewController ()

@end

@implementation DropViewTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256)/255.0
                                                green:arc4random_uniform(256)/255.0
                                                 blue:arc4random_uniform(256)/255.0
                                                alpha:1];
}

#pragma mark =============== Set up navigation bar style ===============
- (void)setupNavigationBar {
    
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
