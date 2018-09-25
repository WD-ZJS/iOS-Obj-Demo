//
//  WDSliderTestTableView.m
//  iOS-Objc-Demo
//
//  Created by 吴丹 on 2018/9/11.
//  Copyright © 2018 forever.love. All rights reserved.
//

#import "WDSliderTestTableView.h"

@interface WDSliderTestTableView ()<UITableViewDelegate, UITableViewDataSource>



@end

@implementation WDSliderTestTableView

- (instancetype)init{
    
    self = [super init];
    if(self){
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = UIColor.whiteColor;
    }
    return self;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 45;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = UIColor.redColor;
    
    UIButton *button = [[UIButton alloc] init];
    [button setImage:[UIImage imageNamed:@"backItem"] forState:UIControlStateNormal];
    button.frame = CGRectMake(15, 45/2-30/2, 30, 30);
    button.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [button addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    return view;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
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
    [self dismiss];
}

- (void)dismiss {
    [UIView animateWithDuration:0.5 animations:^{
        self.frame = CGRectMake(UIScreen.mainScreen.bounds.size.width, 0, UIScreen.mainScreen.bounds.size.width * 4/5, UIScreen.mainScreen.bounds.size.height);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
@end
