//
//  WDPhotoBottomView.m
//  WDPhotoPick
//
//  Created by 吴丹 on 2018/9/13.
//  Copyright © 2018 forever.love. All rights reserved.
//

#import "WDPhotoBottomView.h"

@interface WDPhotoBottomView ()

@property (nonatomic, strong) UIView *topLine;

@end

@implementation WDPhotoBottomView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupSubViewsPropertys];
        [self setupSubViewsConstraints];
    }
    return self;
}

#pragma mark =============== Add controls, set properties ===============
- (void)setupSubViewsPropertys {
    
    self.backgroundColor = UIColor.whiteColor;
    
    self.topLine = [[UIImageView alloc] init];
    self.topLine.backgroundColor = UIColor.lightGrayColor;
    [self addSubview:self.topLine];
    
    self.sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.sureButton setTitle:@"确定" forState:UIControlStateNormal];
    self.sureButton.titleLabel.font = [UIFont systemFontOfSize:13.0];
    [self.sureButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [self.sureButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.sureButton.backgroundColor = UIColor.blueColor;
    [self addSubview:self.sureButton];
    
    self.backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.backButton setTitle:@"返回" forState:UIControlStateNormal];
    self.backButton.titleLabel.font = [UIFont systemFontOfSize:13.0];
    [self.backButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    self.backButton.hidden = true;
    [self addSubview:self.backButton];
}

#pragma mark =============== Setting control layout constraints ===============
- (void)setupSubViewsConstraints {
    
    self.topLine.translatesAutoresizingMaskIntoConstraints = false;
    NSLayoutConstraint *line_top = [NSLayoutConstraint constraintWithItem:self.topLine attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:0];
    NSLayoutConstraint *line_leading = [NSLayoutConstraint constraintWithItem:self.topLine attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1 constant:0];
    NSLayoutConstraint *line_trealing = [NSLayoutConstraint constraintWithItem:self.topLine attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1 constant:0];
    NSLayoutConstraint *line_height = [NSLayoutConstraint constraintWithItem:self.topLine attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:0.5];
    [self addConstraints:@[line_top, line_leading, line_trealing, line_height]];
    
    self.sureButton.translatesAutoresizingMaskIntoConstraints = false;
    NSLayoutConstraint *sureButton_top = [NSLayoutConstraint constraintWithItem:self.sureButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:10];
    NSLayoutConstraint *sureButton_width = [NSLayoutConstraint constraintWithItem:self.sureButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1 constant:UIScreen.mainScreen.bounds.size.width / 8];
    NSLayoutConstraint *sureButton_trealing = [NSLayoutConstraint constraintWithItem:self.sureButton attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1 constant:-15];
    NSLayoutConstraint *sureButton_buttom = [NSLayoutConstraint constraintWithItem:self.sureButton attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:-10];
    [self addConstraints:@[sureButton_top, sureButton_width, sureButton_trealing, sureButton_buttom]];
    
    self.backButton.translatesAutoresizingMaskIntoConstraints = false;
    NSLayoutConstraint *back_top = [NSLayoutConstraint constraintWithItem:self.backButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:10];
    NSLayoutConstraint *back_width = [NSLayoutConstraint constraintWithItem:self.backButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1 constant:UIScreen.mainScreen.bounds.size.width / 8];
    NSLayoutConstraint *backn_trealing = [NSLayoutConstraint constraintWithItem:self.backButton attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1 constant:15];
    NSLayoutConstraint *back_buttom = [NSLayoutConstraint constraintWithItem:self.backButton attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:-10];
    [self addConstraints:@[back_top, back_width, backn_trealing, back_buttom]];
}

- (void)buttonAction:(id)sender {
    if (self.sureButtonBlock) {
        self.sureButtonBlock();
    }
}

@end
