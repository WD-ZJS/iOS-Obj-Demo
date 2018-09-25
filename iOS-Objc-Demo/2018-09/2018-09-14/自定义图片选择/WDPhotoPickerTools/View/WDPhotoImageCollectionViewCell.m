//
//  WDPhotoImageCollectionViewCell.m
//  WDPhotoPick
//
//  Created by 吴丹 on 2018/9/13.
//  Copyright © 2018 forever.love. All rights reserved.
//

#import "WDPhotoImageCollectionViewCell.h"

@interface WDPhotoImageCollectionViewCell ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIButton *selectButton;

@end

@implementation WDPhotoImageCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubViewsPropertys];
        [self setupSubViewsConstraints];
    }
    return self;
}

- (void)setModel:(WDPhotoImageModel *)model {
    _model = model;
    self.imageView.image = model.image;
    self.selectButton.selected = model.isSelected;
}

#pragma mark =============== Add controls, set properties ===============
- (void)setupSubViewsPropertys {
    self.imageView = [[UIImageView alloc] init];
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.clipsToBounds = YES;
    [self.contentView addSubview:self.imageView];
    
    self.selectButton = [[UIButton alloc] init];
    [self.selectButton setImage:[UIImage imageNamed:@"wd_no_selected"] forState:UIControlStateNormal];
    [self.selectButton setImage:[UIImage imageNamed:@"wd_selected"] forState:UIControlStateSelected];
    [self.selectButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.selectButton];
}

#pragma mark =============== Setting control layout constraints ===============
- (void)setupSubViewsConstraints {
    self.imageView.translatesAutoresizingMaskIntoConstraints = false;
    NSLayoutConstraint *img_top = [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1 constant:0];
    NSLayoutConstraint *img_leading = [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeading multiplier:1 constant:0];
    NSLayoutConstraint *img_trealing = [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTrailing multiplier:1 constant:0];
    NSLayoutConstraint *img_bottom = [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    [self.contentView addConstraints:@[img_top, img_bottom, img_leading, img_trealing]];
    
    self.selectButton.translatesAutoresizingMaskIntoConstraints = false;
    NSLayoutConstraint *button_top = [NSLayoutConstraint constraintWithItem:self.selectButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1 constant:0];
    NSLayoutConstraint *button_trealing = [NSLayoutConstraint constraintWithItem:self.selectButton attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTrailing multiplier:1 constant:0];
    NSLayoutConstraint *button_width = [NSLayoutConstraint constraintWithItem:self.selectButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1 constant:30];
    NSLayoutConstraint *button_height = [NSLayoutConstraint constraintWithItem:self.selectButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:30];
    [self.contentView addConstraints:@[button_top, button_trealing, button_width, button_height]];
}

- (void)buttonAction:(UIButton *)sender {    
    sender.selected = !self.model.isSelected;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(photoSelectedAtCell:)]) {
        [self.delegate photoSelectedAtCell:self];
    }
}

@end
