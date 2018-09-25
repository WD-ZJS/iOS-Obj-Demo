//
//  WDSegmentView.m
//  iOS-Demo
//
//  Created by 吴丹 on 2018/9/5.
//  Copyright © 2018 forever.love. All rights reserved.
//

#import "WDSegmentView.h"

@interface WDSegmentView  ()

/// 用于按钮平分宽度
@property (nonatomic, strong) UIStackView *stackView;
/// 底部分割线
@property (nonatomic, strong) UIView *bottomLineView;
/// 活动指示器
@property (nonatomic, strong) UIView *indecatorView;
/// 标题数组
@property (nonatomic, strong) NSArray *titleArray;
/// 储存点击的按钮
@property (nonatomic, strong) NSMutableArray *buttonArray;

@end

@implementation WDSegmentView

- (instancetype)initWithTitleArray:(NSArray *)aTitleArray {
    self = [super init];
    if(self){
        self.titleArray = aTitleArray;
        self.buttonArray = [NSMutableArray array];
        [self setupSubviews];
        [self setupSubviewsConstraints];
    }
    return self;
}

- (void)layoutSubviews {
    NSLog(@"%@",NSStringFromCGRect(self.frame));
    self.stackView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height-0.8);
    [self addSubview:self.stackView];
    
    self.bottomLineView.frame = CGRectMake(0, self.frame.size.height-0.8, self.frame.size.width, 0.8);
    [self addSubview:self.bottomLineView];
    
    self.indecatorView.frame = CGRectMake(self.frame.size.width/self.titleArray.count/4, self.frame.size.height-0.8, self.frame.size.width/self.titleArray.count/2, 0.8);
    [self addSubview:self.indecatorView];
    
    
    for (int i=0; i<self.titleArray.count; i++) {
        UIButton *b = [UIButton buttonWithType:UIButtonTypeCustom];
        [b setTitle:self.titleArray[i] forState:UIControlStateNormal];
        [b setTitleColor:UIColor.lightGrayColor forState:UIControlStateNormal];
        [b setTitleColor:UIColor.orangeColor forState:UIControlStateSelected];
        [b addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        b.tag = 10 + i;
        [self.stackView addArrangedSubview:b];
        if (i==0) {
            [self.buttonArray addObject:b];
            b.selected = true;
        }
    }
}

- (void)setButtonIndex:(NSInteger)buttonIndex {
    _buttonIndex = buttonIndex;
    
    UIButton *button =  [self viewWithTag:buttonIndex+10];
    [self.buttonArray addObject:button];
    button.selected = true;
    
    for (UIButton *b  in self.buttonArray) {
        if (![button isEqual:b]) {
            b.selected = false;
        }
    }
    
    CGFloat X = self.frame.size.width / self.titleArray.count * buttonIndex;
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.indecatorView.frame = CGRectMake(X + self.frame.size.width/self.titleArray.count/4, self.frame.size.height-0.8, self.frame.size.width/self.titleArray.count/2, 0.8);
    } completion:^(BOOL finished) {
        
    }];
}

- (void)buttonAction:(UIButton *)sender {
    [self.buttonArray addObject:sender];
    
    if (self.buttonClickBlock) {
        self.buttonClickBlock(sender.tag-10);
    }
    
    for (UIButton *b  in self.buttonArray) {
        if ([sender isEqual:b]) {
            b.selected = true;
        } else {
            b.selected = false;
        }
    }
    
    CGFloat X = self.frame.size.width / self.titleArray.count * (sender.tag - 10);
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.indecatorView.frame = CGRectMake(X + self.frame.size.width/self.titleArray.count/4, self.frame.size.height-0.8, self.frame.size.width/self.titleArray.count/2, 0.8);
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark - SetupSubviewsUI
- (void)setupSubviews{

}

#pragma mark - SetupSubviewsConstraints
- (void)setupSubviewsConstraints{

}

- (UIStackView *)stackView {
    if (!_stackView) {
        _stackView = [[UIStackView alloc] init];
        _stackView.axis = UILayoutConstraintAxisHorizontal;
        _stackView.distribution = UIStackViewDistributionFillEqually;
    }
    return _stackView;
}

- (UIView *)bottomLineView {
    if (!_bottomLineView) {
        _bottomLineView = [[UIView alloc] init];
        _bottomLineView.backgroundColor = UIColor.lightGrayColor;
    }
    return _bottomLineView;
}

- (UIView *)indecatorView {
    if (!_indecatorView) {
        _indecatorView = [[UIView alloc] init];
        _indecatorView.backgroundColor = UIColor.orangeColor;
    }
    return _indecatorView;
}

@end
