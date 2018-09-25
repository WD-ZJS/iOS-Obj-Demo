//
//  WDPhotoHUD.m
//  WDPhotoPick
//
//  Created by 吴丹 on 2018/9/13.
//  Copyright © 2018 forever.love. All rights reserved.
//

#import "WDPhotoHUD.h"

@interface WDPhotoHUD ()

@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UILabel *contextLabel;
@property (nonatomic, strong) UIButton *iconButton;

@end

@implementation WDPhotoHUD

+ (instancetype)hud {
    static dispatch_once_t onceToken;
    static WDPhotoHUD *manager;
    dispatch_once(&onceToken, ^{
        manager = [[WDPhotoHUD alloc] init];
    });
    return manager;
}


- (void)showViewWithindicatorViewWithRemindText:(NSString *)remindText {
    for (UIView *view in self.containerView.subviews) {
        [view removeFromSuperview];
    }
    
    self.frame = UIScreen.mainScreen.bounds;
    [UIApplication.sharedApplication.delegate.window addSubview:self];
    
    self.containerView.backgroundColor = UIColor.darkGrayColor;
    self.indicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
    
    CGRect frame = (CGRect){CGPointZero, CGSizeMake(80, 80)};
    frame.origin.x = CGRectGetMidX(self.frame);
    frame.origin.y = CGRectGetMidY(self.frame);
    self.containerView.frame = (CGRect){CGPointMake(frame.origin.x-40, frame.origin.y-40),CGSizeMake(80, 80)};
    
    
    if (remindText.length != 0) {
        self.indicatorView.frame = CGRectMake(0, 0, self.containerView.frame.size.width, self.containerView.frame.size.height-20);
        CGAffineTransform transform = CGAffineTransformMakeScale(1.4f, 1.4f);
        self.indicatorView.transform = transform;
        self.contextLabel.frame = CGRectMake(0, self.containerView.frame.size.height-20, self.containerView.frame.size.width, 15);
        self.contextLabel.text = remindText;
        self.contextLabel.textColor = UIColor.whiteColor;
    }
    [self.containerView addSubview:self.indicatorView];
    [self.containerView addSubview:self.contextLabel];
}

- (UIView *)containerView {
    if (!_containerView) {
        _containerView = [[UIView alloc] init];
        _containerView.backgroundColor = UIColor.whiteColor;
        _containerView.layer.cornerRadius = 5;
        _containerView.frame = CGRectMake(0, 0, 80, 80);
        _containerView.center = self.center;
        [self addSubview:_containerView];
    }
    return _containerView;
}

- (UIButton *)iconButton {
    if (!_iconButton) {
        _iconButton = [[UIButton alloc] init];
        _iconButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _iconButton;
}

- (UILabel *)contextLabel {
    if (!_contextLabel) {
        _contextLabel = [[UILabel alloc] init];
        _contextLabel.textAlignment = NSTextAlignmentCenter;
        [self.containerView addSubview:_contextLabel];
        _contextLabel.textColor = UIColor.blackColor;
    }
    return _contextLabel;
}

- (UIActivityIndicatorView *)indicatorView {
    if (!_indicatorView) {
        _indicatorView = [[UIActivityIndicatorView alloc] init];
        [_indicatorView setHidesWhenStopped:true];
        _indicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
        _indicatorView.frame = self.containerView.bounds;
        CGAffineTransform transform = CGAffineTransformMakeScale(1.4f, 1.4f);
        _indicatorView.transform = transform;
        [_indicatorView startAnimating];
    }
    return _indicatorView;
}

- (void)dismissView {
    [self removeFromSuperview];
}

@end
