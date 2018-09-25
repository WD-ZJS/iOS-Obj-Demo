//
//  WDModalViewController.m
//  iOS-Objc-Demo
//
//  Created by 吴丹 on 2018/9/18.
//  Copyright © 2018 forever.love. All rights reserved.
//

#import "WDModalViewController.h"
#import "ModalTestViewController.h"

#import "UIViewController+WDPopover.h"

#import "WDPopoverPresentationManager.h"

@interface WDModalViewController ()

@end

@implementation WDModalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.wdNavigationBar.centerButton setTitle:@"模态弹窗" forState:UIControlStateNormal];
}
- (IBAction)alterAction:(id)sender {
    ModalTestViewController *vc = [ModalTestViewController new];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self wd_centerPresentController:nav presentedSize:CGSizeMake(200, 300) completeHandle:^(BOOL presented) {
        if (presented) {
            NSLog(@"弹出了");
        }else{
            NSLog(@"消失了");
        }
    }];
}

- (IBAction)sheetAction:(id)sender {
    ModalTestViewController *vc = [ModalTestViewController new];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self wd_bottomPresentController:nav presentedHeight:300 completeHandle:^(BOOL presented) {
        if (presented) {
            NSLog(@"弹出了");
        }else{
            NSLog(@"消失了");
        }
    }];
}

- (IBAction)popAction:(id)sender {
    
    UIButton *button = (UIButton *)sender;
    
    ModalTestViewController *contentVC = [[ModalTestViewController alloc] init];

    WDPopoverPresentationManager *manager = [[WDPopoverPresentationManager alloc] init];
    [manager setupPopoverPresentationWithFromController:self
                                    presentedController:contentVC
                                        backgroundColor:[UIColor greenColor]
                                   preferredContentSize:CGSizeZero
                                             sourceView:button
                                             sourceRect:button.bounds
                               permittedArrowDirections:UIPopoverArrowDirectionUp];
}
@end
