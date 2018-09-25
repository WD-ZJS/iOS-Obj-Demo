//
//  WDPhotoNavigationBar.m
//  WDPhotoPick
//
//  Created by 吴丹 on 2018/9/13.
//  Copyright © 2018 forever.love. All rights reserved.
//

#import "WDPhotoNavigationBar.h"

@interface WDPhotoNavigationBar ()

@property (nonatomic, strong) UIView *bottomLine;

@end

@implementation WDPhotoNavigationBar

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
    self.bottomLine = [[UIImageView alloc] init];
    self.bottomLine.backgroundColor = UIColor.lightGrayColor;
    [self addSubview:self.bottomLine];
    
    self.centerLabel = [[UILabel alloc] init];
    self.centerLabel.textAlignment = NSTextAlignmentCenter;
    [self.centerLabel adjustsFontSizeToFitWidth];
    [self addSubview:self.centerLabel];
    
    self.cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [self.cancelButton setTitleColor:UIColor.blueColor forState:UIControlStateNormal];
    [self.cancelButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.cancelButton];
}

#pragma mark =============== Setting control layout constraints ===============
- (void)setupSubViewsConstraints {
    
    self.bottomLine.translatesAutoresizingMaskIntoConstraints = false;
    NSLayoutConstraint *line_top = [NSLayoutConstraint constraintWithItem:self.bottomLine attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:-0.5];
    NSLayoutConstraint *line_leading = [NSLayoutConstraint constraintWithItem:self.bottomLine attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1 constant:0];
    NSLayoutConstraint *line_trealing = [NSLayoutConstraint constraintWithItem:self.bottomLine attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1 constant:0];
    NSLayoutConstraint *line_height = [NSLayoutConstraint constraintWithItem:self.bottomLine attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:0.5];
    [self addConstraints:@[line_top, line_leading, line_trealing, line_height]];
    
    self.centerLabel.translatesAutoresizingMaskIntoConstraints = false;
    NSLayoutConstraint *center_centerY = [NSLayoutConstraint constraintWithItem:self.centerLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:-22];
    NSLayoutConstraint *centerleading = [NSLayoutConstraint constraintWithItem:self.centerLabel attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1 constant:0];
    NSLayoutConstraint *center_trealing = [NSLayoutConstraint constraintWithItem:self.centerLabel attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1 constant:0];
    NSLayoutConstraint *center_height = [NSLayoutConstraint constraintWithItem:self.centerLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:44];
    [self addConstraints:@[center_centerY, centerleading, center_trealing, center_height]];
    
    self.cancelButton.translatesAutoresizingMaskIntoConstraints = false;
    NSLayoutConstraint *cancel_centerY = [NSLayoutConstraint constraintWithItem:self.cancelButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.centerLabel attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    NSLayoutConstraint *cancel_width = [NSLayoutConstraint constraintWithItem:self.cancelButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1 constant:UIScreen.mainScreen.bounds.size.width/6];
    NSLayoutConstraint *cancel_trealing = [NSLayoutConstraint constraintWithItem:self.cancelButton attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1 constant:-15];
    NSLayoutConstraint *cancel_height = [NSLayoutConstraint constraintWithItem:self.cancelButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:44];
    [self addConstraints:@[cancel_centerY, cancel_width, cancel_trealing, cancel_height]];
}

- (void)buttonAction:(id)sender {
    if (self.cancelButtonBlock) {
        self.cancelButtonBlock();
    }
}

@end
