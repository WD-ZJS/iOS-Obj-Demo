//
//  NoPicView.m
//  WDPhotoPick
//
//  Created by 吴丹 on 2018/9/13.
//  Copyright © 2018 forever.love. All rights reserved.
//

#import "WDPhotoPlaceHolderView.h"

@interface WDPhotoPlaceHolderView ()

@end

@implementation WDPhotoPlaceHolderView

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
    self.imageView = [[UIImageView alloc] init];
    self.imageView.image = [UIImage imageNamed:@"wd_empty"];
    self.imageView.contentMode = UIImageOrientationDown;
    [self addSubview:self.imageView];
    
    self.remindLabel = [[UILabel alloc] init];
    self.remindLabel.text = @"暂无图片，去拍几张吧~~~";
    self.remindLabel.textColor = UIColor.lightGrayColor;
    self.remindLabel.textAlignment = NSTextAlignmentCenter;
    [self.remindLabel adjustsFontSizeToFitWidth];
    self.remindLabel.numberOfLines = 0;
    [self addSubview:self.remindLabel];
}

#pragma mark =============== Setting control layout constraints ===============
- (void)setupSubViewsConstraints {
    self.imageView.translatesAutoresizingMaskIntoConstraints = false;
    NSLayoutConstraint *img_bottom = [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:10];
    NSLayoutConstraint *img_leading = [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1 constant:0];
    NSLayoutConstraint *img_trealing = [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1 constant:0];
    [self addConstraints:@[img_bottom, img_leading, img_trealing]];
    
    self.remindLabel.translatesAutoresizingMaskIntoConstraints = false;
    NSLayoutConstraint *text_top = [NSLayoutConstraint constraintWithItem:self.remindLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.imageView attribute:NSLayoutAttributeBottom multiplier:1 constant:25];
    NSLayoutConstraint *textleading = [NSLayoutConstraint constraintWithItem:self.remindLabel attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1 constant:0];
    NSLayoutConstraint *text_trealing = [NSLayoutConstraint constraintWithItem:self.remindLabel attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1 constant:0];
    [self addConstraints:@[text_top, textleading, text_trealing]];
}

@end
