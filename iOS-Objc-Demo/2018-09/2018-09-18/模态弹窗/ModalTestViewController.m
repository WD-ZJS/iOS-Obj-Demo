//
//  ModalTestViewController.m
//  iOS-Objc-Demo
//
//  Created by 吴丹 on 2018/9/18.
//  Copyright © 2018 forever.love. All rights reserved.
//

#import "ModalTestViewController.h"
#import "ModalTestNextViewController.h"

@interface ModalTestViewController ()

@end

@implementation ModalTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"测试视图";
}

- (void)pushVC {
    ModalTestNextViewController *controller = [[ModalTestNextViewController alloc] init];
    [self.navigationController pushViewController:controller animated:true];
}

- (IBAction)sureAction:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}
@end

#pragma mark =============== UITableViewDataSource ===============

@implementation ModalTestViewController (UITableViewDataSource)

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    
    return cell;
}
@end

#pragma mark =============== UITableViewDelegate ===============

@implementation ModalTestViewController (UITableViewDelegate)

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    [self pushVC];
}

@end
