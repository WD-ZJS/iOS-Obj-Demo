//
//  TemplateOfViewController.m
//  iOS-Demo
//
//  Created by 吴丹 on 2018/9/6.
//  Copyright © 2018 forever.love. All rights reserved.
//

#import "TemplateOfViewController.h"

@interface TemplateOfViewController ()

@end

@implementation TemplateOfViewController

#pragma mark =============== Dealloc ===============
- (void)dealloc {
    NSLog(@"%@被销毁",[self class]);
}

#pragma mark =============== ViewControllerLifeyCyle ===============
- (void)viewDidLoad {
    [super viewDidLoad];
}

/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/

#pragma mark =============== Set up navigation bar style ===============
- (void)setupNavigationBar { }

#pragma mark =============== Add controls, set properties ===============
- (void)setupSubViewsPropertys { }

#pragma mark =============== Setting control layout constraints ===============
- (void)setupSubViewsConstraints { }

#pragma mark =============== Data initialization ===============
- (void)dataInitialization { }

#pragma mark =============== Events ===============

#pragma mark =============== PirvateMethod ===============

#pragma mark =============== PublicMethod ===============

#pragma mark =============== Network request ===============

#pragma mark =============== Getter ===============

#pragma mark =============== Setter ===============

@end

#pragma mark =============== UITableViewDataSource ===============

@interface TemplateOfViewController (UITableViewDataSource) <UITableViewDataSource>

@end

@implementation TemplateOfViewController (UITableViewDataSource)

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}
@end

#pragma mark =============== UITableViewDelegate ===============

@interface TemplateOfViewController (UITableViewDelegate) <UITableViewDelegate>

@end

@implementation TemplateOfViewController (UITableViewDelegate)

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:true];
}

@end
