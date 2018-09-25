//
//  DropViewTest-01ViewController.m
//  iOS-Demo
//
//  Created by 吴丹 on 2018/9/7.
//  Copyright © 2018 forever.love. All rights reserved.
//

#import "DropViewTest-1ViewController.h"
#import "WDDropView/WDDropDownView.h"

@interface DropViewTest_1ViewController ()

@property (nonatomic, strong) NSArray<NSString *> *dataArray;
@property (nonatomic, assign) NSInteger selectedIndex;

@end

@implementation DropViewTest_1ViewController


#pragma mark =============== Dealloc ===============
- (void)dealloc {
    NSLog(@"%@被销毁",[self class]);
}

#pragma mark =============== ViewControllerLifeyCyle ===============
- (void)viewDidLoad {
    [super viewDidLoad];
    [self dataInitialization];
    [self setupSubViewsPropertys];
    [self setupSubViewsConstraints];
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
- (void)setupNavigationBar {
    
}

#pragma mark =============== Add controls, set properties ===============
- (void)setupSubViewsPropertys {
    [self.view addSubview:self.tableView];
}

#pragma mark =============== Setting control layout constraints ===============
- (void)setupSubViewsConstraints {
    self.tableView.translatesAutoresizingMaskIntoConstraints = false;
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:0];
    NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1 constant:0];
    NSLayoutConstraint *trealing = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1 constant:0];
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    [self.view addConstraints:@[top,leading,trealing,bottom]];
}

#pragma mark =============== Data initialization ===============
- (void)dataInitialization {
    self.selectedIndex = -1;
    self.dataArray = @[@"智能排序" ,@"最新上架" ,@"价格最低", @"价格最高", @"销量最高"];
}

#pragma mark =============== UITableViewDataSource ===============
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = [NSString stringWithFormat:@"cellId%ld",indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.textLabel.text = self.dataArray[indexPath.row];
    
    if (self.selectedIndex == indexPath.row) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        tableView.tintColor = UIColor.orangeColor;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

#pragma mark =============== UITableViewDelegate ===============
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    self.selectedIndex = indexPath.row;
    [self.tableView reloadData];
    // controller中发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:WDchangeTitle object:self userInfo:@{@"title":self.dataArray[indexPath.row]}];
}

#pragma mark =============== Events ===============

#pragma mark =============== PirvateMethod ===============

#pragma mark =============== PublicMethod ===============

#pragma mark =============== Network request ===============

#pragma mark =============== Getter ===============

#pragma mark =============== Setter ===============

@end
