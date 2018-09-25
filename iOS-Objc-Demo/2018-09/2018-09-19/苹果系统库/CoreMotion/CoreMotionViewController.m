//
//  CoreMotionViewController.m
//  iOS-Objc-Demo
//
//  Created by zjs on 2018/9/25.
//  Copyright © 2018 forever.love. All rights reserved.
//

#import "CoreMotionViewController.h"
#import "UICountingLabel.h"
#import "DNPedometerManager.h"
#import "DNPedometerCell.h"
#import "DNPedometerModel.h"

@interface CoreMotionViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UICountingLabel *stepLabel;

@property (nonatomic, strong) NSMutableArray * dataArray;
@end

@implementation CoreMotionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSubViewsPropertys];
    [self configUIForData];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark =============== Set up navigation bar style ===============
- (void)setupNavigationBar {
    [super setupNavigationBar];
    [self.wdNavigationBar.centerButton setTitle:@"苹果系统库" forState:UIControlStateNormal];
}

#pragma mark =============== Add controls, set properties ===============
- (void)setupSubViewsPropertys {
    self.stepLabel.format = @"%ld";
    self.stepLabel.layer.cornerRadius = 54.f;
    self.stepLabel.layer.masksToBounds = YES;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    [self.tableView registerNib:[UINib nibWithNibName:@"DNPedometerCell" bundle:nil] forCellReuseIdentifier:@"DNPedometerCell"];
}

- (void)configUIForData {
    
    
    [[DNPedometerManager defaultManager] dn_startCalculatorStep:^(NSString * _Nonnull steps, NSString * _Nonnull distance) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.dataArray removeAllObjects];
            
            DNPedometerModel * model1 = [[DNPedometerModel alloc] initWithTitle:@"步数" sportData:steps currentDate:[self getCurrentDate]];
            DNPedometerModel * model2 = [[DNPedometerModel alloc] initWithTitle:@"距离" sportData:distance currentDate:[self getCurrentDate]];
            [self.dataArray addObject:model1];
            [self.dataArray addObject:model2];
            [self.stepLabel countFromZeroTo:[steps integerValue] withDuration:3.f];
            [self.tableView reloadData];
        });
    }];
}

#pragma mark =============== Setting control layout constraints ===============
- (void)setupSubViewsConstraints {
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DNPedometerModel * model = self.dataArray[indexPath.row];
    DNPedometerCell * cell = [tableView dequeueReusableCellWithIdentifier:@"DNPedometerCell" forIndexPath:indexPath];
    cell.model = model;
    return cell;
}

- (NSString *)getCurrentDate {
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"HH:mm:ss";
    NSString * currentDate = [formatter stringFromDate:[NSDate date]];
    return currentDate;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end
