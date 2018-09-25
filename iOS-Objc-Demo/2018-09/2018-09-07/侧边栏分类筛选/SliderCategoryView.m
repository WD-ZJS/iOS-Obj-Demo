//
//  SliderCategoryView.m
//  iOS-Objc-Demo
//
//  Created by 吴丹 on 2018/9/11.
//  Copyright © 2018 forever.love. All rights reserved.
//

#import "SliderCategoryView.h"
#import "WDSliderTestTableView.h"

@interface SliderCategoryView  ()<UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) WDSliderTestTableView *homeTableView;

@end

@implementation SliderCategoryView

- (instancetype)init{
    
    self = [super init];
    if(self){
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissView)];
        tap.delegate = self;
        [self addGestureRecognizer:tap];
        [self setupSubviews];
    }
    return self;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    } else if ([NSStringFromClass([touch.view class]) isEqualToString:@"UICollectionViewCellContentView"]) {
        return NO;
    }
    return YES;
}

- (void)showView {
    
    self.frame = CGRectMake(UIScreen.mainScreen.bounds.size.width, 0, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height);
    self.alpha = 0;
    [UIView animateWithDuration:0.8 animations:^{
        self.frame = CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height);
        [[[[UIApplication sharedApplication] delegate] window] addSubview:self];
        self.alpha = 1;
    }];
}

- (void)dismissView {
    
    [UIView animateWithDuration:0.8 animations:^{
        self.frame = CGRectMake(UIScreen.mainScreen.bounds.size.width, 0, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height);
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - SetupSubviewsUI
- (void)setupSubviews{
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    // 默认加载显示TableView
    [self addSubview:self.tableView];
}

- (WDSliderTestTableView *)homeTableView {
    if (!_homeTableView) {
        _homeTableView = [[WDSliderTestTableView alloc] init];
    }
    return _homeTableView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = UIColor.whiteColor;
        _tableView.frame = CGRectMake(UIScreen.mainScreen.bounds.size.width/5, 0, UIScreen.mainScreen.bounds.size.width * 4/5, UIScreen.mainScreen.bounds.size.height);
    }
    return _tableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%ld+%ld",indexPath.section,indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.homeTableView.frame = CGRectMake(UIScreen.mainScreen.bounds.size.width, 0, UIScreen.mainScreen.bounds.size.width * 4/5, UIScreen.mainScreen.bounds.size.height);
    
    [UIView animateWithDuration:0.5 animations:^{
        self.homeTableView.frame = CGRectMake(UIScreen.mainScreen.bounds.size.width/5, 0, UIScreen.mainScreen.bounds.size.width * 4/5, UIScreen.mainScreen.bounds.size.height);
        [self addSubview:self.homeTableView];
    } completion:^(BOOL finished) {
        
    }];
}

@end
