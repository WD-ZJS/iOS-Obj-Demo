//
//  WDLoadingHUD.m
//  WDMediaPlayer
//
//  Created by wudan on 2018/9/27.
//  Copyright © 2018 wudan. All rights reserved.
//

#import "WDLoadingHUD.h"

@interface WDLoadingHUD ()

/** < 背景视图 > */
@property (nonatomic, strong) UIView *backgroundView;
/** < 系统loding > */
@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;
@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) UIImageView *lodingImageView;
@property (nonatomic, strong) UIView *containerView;
@end

@implementation WDLoadingHUD

+ (instancetype)hud {
    static dispatch_once_t onceToken;
    static WDLoadingHUD *hud;
    dispatch_once(&onceToken, ^{
        hud = [[WDLoadingHUD alloc] init];
    });
    return hud;
}

#pragma - 显示默认菊花样式
- (void)showNormalIndicatorWithStyle:(WDLoadingHUDColorStyle)style {
    
    [self showHUD];
    
    [self.containerView addSubview:self.backgroundView];
    self.backgroundView.layer.cornerRadius = 10;
    
    self.backgroundView.translatesAutoresizingMaskIntoConstraints = false;
    NSLayoutConstraint *c_centerX = [NSLayoutConstraint constraintWithItem:self.backgroundView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    NSLayoutConstraint *c_centerY = [NSLayoutConstraint constraintWithItem:self.backgroundView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    NSLayoutConstraint *c_width = [NSLayoutConstraint constraintWithItem:self.backgroundView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1 constant:UIScreen.mainScreen.bounds.size.width / 5];
    NSLayoutConstraint *c_height = [NSLayoutConstraint constraintWithItem:self.backgroundView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:UIScreen.mainScreen.bounds.size.width / 5];
    [self.containerView addConstraints:@[c_centerX, c_centerY, c_width, c_height]];
    
    [self.indicatorView startAnimating];
    [self.backgroundView addSubview:self.indicatorView];
    self.indicatorView.translatesAutoresizingMaskIntoConstraints = false;
    NSLayoutConstraint *in_centerX = [NSLayoutConstraint constraintWithItem:self.indicatorView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.backgroundView attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    NSLayoutConstraint *in_centerY = [NSLayoutConstraint constraintWithItem:self.indicatorView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.backgroundView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    [self.backgroundView addConstraints:@[in_centerX, in_centerY]];
    self.indicatorView.transform = CGAffineTransformMakeScale(1.5, 1.5);
    
    if (style == WDLoadingHUDColorStyleLight) {
        self.backgroundView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.9];
        self.indicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    } else {
        self.backgroundView.backgroundColor = UIColor.darkGrayColor;
        self.indicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
    }
}

#pragma - 仅显示文字
- (void)showNormalTitle:(NSString *)title style:(WDLoadingHUDColorStyle)style {
    
    [self showHUD];
    
    [self.containerView addSubview:self.backgroundView];
    self.backgroundView.layer.cornerRadius = 10;
    
    [self.backgroundView addSubview:self.textLabel];
    self.textLabel.text = title;
    
    CGRect rect = [title boundingRectWithSize:CGSizeMake(UIScreen.mainScreen.bounds.size.width * 0.7, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:self.textLabel.font} context:nil];
    
    if (style == WDLoadingHUDColorStyleLight) {
        self.backgroundView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.9];
        self.textLabel.textColor = UIColor.darkGrayColor; 
    } else {
        self.backgroundView.backgroundColor = UIColor.darkGrayColor;
        self.textLabel.textColor = UIColor.whiteColor;
    }
    
    CGFloat TextW = 0;
    CGFloat TextH = rect.size.height;
    
    if (rect.size.width >= UIScreen.mainScreen.bounds.size.width / 5 && rect.size.width <= UIScreen.mainScreen.bounds.size.width * 0.7){
        TextW = rect.size.width;
        
    } else if (rect.size.width < UIScreen.mainScreen.bounds.size.width / 5){
        TextW = UIScreen.mainScreen.bounds.size.width / 5;
        
    } else {
        TextW = UIScreen.mainScreen.bounds.size.width * 0.7;
    }
    
    self.backgroundView.translatesAutoresizingMaskIntoConstraints = false;
    NSLayoutConstraint *c_centerX = [NSLayoutConstraint constraintWithItem:self.backgroundView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    NSLayoutConstraint *c_centerY = [NSLayoutConstraint constraintWithItem:self.backgroundView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    NSLayoutConstraint *c_width = [NSLayoutConstraint constraintWithItem:self.backgroundView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1 constant:TextW + 20];
    NSLayoutConstraint *c_height = [NSLayoutConstraint constraintWithItem:self.backgroundView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:TextH + 20];
    [self.containerView addConstraints:@[c_centerX, c_centerY, c_width, c_height]];
    
    self.textLabel.translatesAutoresizingMaskIntoConstraints = false;
    NSLayoutConstraint *t_centerX = [NSLayoutConstraint constraintWithItem:self.textLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.backgroundView attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    NSLayoutConstraint *t_centerY = [NSLayoutConstraint constraintWithItem:self.textLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.backgroundView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    NSLayoutConstraint *t_width = [NSLayoutConstraint constraintWithItem:self.textLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1 constant:TextW];
    NSLayoutConstraint *t_height = [NSLayoutConstraint constraintWithItem:self.textLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:TextH];
    [self.backgroundView addConstraints:@[t_centerX, t_centerY, t_width, t_height]];
}

#pragma - 显示标题和文字
- (void)showTitle:(NSString *)title imageName:(NSString *)imageName direction:(WDLoadingHUDImageDirection)aDirection style:(WDLoadingHUDColorStyle)style {
    [self showHUD];
    
     CGRect rect = [title boundingRectWithSize:CGSizeMake(UIScreen.mainScreen.bounds.size.width * 0.7, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:self.textLabel.font} context:nil];
    
    [self.containerView addSubview:self.backgroundView];
    self.backgroundView.layer.cornerRadius = 10;
    self.backgroundView.translatesAutoresizingMaskIntoConstraints = false;
    
    self.textLabel.translatesAutoresizingMaskIntoConstraints = false;
    [self.backgroundView addSubview:self.textLabel];
    self.textLabel.text = title;
    
    self.lodingImageView.translatesAutoresizingMaskIntoConstraints = false;
    self.lodingImageView.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [self.backgroundView addSubview:self.lodingImageView];
    
    CGSize imageSize = self.lodingImageView.image.size;
    
    CGFloat TextW = 0;
    
    switch (aDirection) {
        case WDLoadingHUDImageDirectionTop:{
            CGFloat TextH = rect.size.height;
            self.textLabel.textAlignment = NSTextAlignmentCenter;
            if (rect.size.width >= UIScreen.mainScreen.bounds.size.width / 5 && rect.size.width <= UIScreen.mainScreen.bounds.size.width * 0.7){
                TextW = rect.size.width;
            } else if (rect.size.width < UIScreen.mainScreen.bounds.size.width / 5){
                TextW = UIScreen.mainScreen.bounds.size.width / 5;
            } else {
                TextW = UIScreen.mainScreen.bounds.size.width * 0.7;
            }
            
            NSLayoutConstraint *c_centerX = [NSLayoutConstraint constraintWithItem:self.backgroundView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
            NSLayoutConstraint *c_centerY = [NSLayoutConstraint constraintWithItem:self.backgroundView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
            NSLayoutConstraint *c_width = [NSLayoutConstraint constraintWithItem:self.backgroundView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1 constant:TextW + imageSize.width + 20];
            NSLayoutConstraint *c_height =  [NSLayoutConstraint constraintWithItem:self.backgroundView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:TextH + 20 + imageSize.height + 10];
            [self.containerView addConstraints:@[c_centerX, c_centerY, c_width, c_height]];
            
            NSLayoutConstraint *img_top = [NSLayoutConstraint constraintWithItem:self.lodingImageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.backgroundView attribute:NSLayoutAttributeTop multiplier:1 constant:10];
            NSLayoutConstraint *img_centerX = [NSLayoutConstraint constraintWithItem:self.lodingImageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.backgroundView attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
            [self.backgroundView addConstraints:@[img_centerX, img_top]];
            
            NSLayoutConstraint *t_top = [NSLayoutConstraint constraintWithItem:self.textLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.lodingImageView attribute:NSLayoutAttributeBottom multiplier:1 constant:10];
            NSLayoutConstraint *t_centerX = [NSLayoutConstraint constraintWithItem:self.textLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.backgroundView attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
            NSLayoutConstraint *t_width = [NSLayoutConstraint constraintWithItem:self.textLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1 constant:TextW];
            [self.backgroundView addConstraints:@[t_top, t_centerX, t_width]];            
        }
            break;
        case WDLoadingHUDImageDirectionLeft:{
            
            self.textLabel.textAlignment = NSTextAlignmentLeft;
            rect = [title boundingRectWithSize:CGSizeMake(UIScreen.mainScreen.bounds.size.width * 0.35, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:self.textLabel.font} context:nil];
            
            CGFloat TextH = rect.size.height;
            
            if (rect.size.width >= UIScreen.mainScreen.bounds.size.width / 5 && rect.size.width <= UIScreen.mainScreen.bounds.size.width * 0.35){
                TextW = rect.size.width;
            } else if (rect.size.width < UIScreen.mainScreen.bounds.size.width / 5){
                TextW = UIScreen.mainScreen.bounds.size.width / 5;
            } else {
                TextW = UIScreen.mainScreen.bounds.size.width * 0.35;
            }
            
            NSLayoutConstraint *c_centerX = [NSLayoutConstraint constraintWithItem:self.backgroundView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
            NSLayoutConstraint *c_centerY = [NSLayoutConstraint constraintWithItem:self.backgroundView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
            NSLayoutConstraint *c_width = [NSLayoutConstraint constraintWithItem:self.backgroundView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1 constant:TextW + imageSize.width + 20];
            NSLayoutConstraint *c_height;
            if ((TextH + 20) > imageSize.height) {
                c_height = [NSLayoutConstraint constraintWithItem:self.backgroundView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:TextH + 30];
            } else {
                c_height = [NSLayoutConstraint constraintWithItem:self.backgroundView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:imageSize.height + 30];
            }
            
            [self.containerView addConstraints:@[c_centerX, c_centerY, c_width, c_height]];
            
            NSLayoutConstraint *img_centerY = [NSLayoutConstraint constraintWithItem:self.lodingImageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.backgroundView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
            NSLayoutConstraint *img_leading = [NSLayoutConstraint constraintWithItem:self.lodingImageView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.backgroundView attribute:NSLayoutAttributeLeading multiplier:1 constant:10];
            [self.backgroundView addConstraints:@[img_centerY, img_leading]];
            
            NSLayoutConstraint *t_leading = [NSLayoutConstraint constraintWithItem:self.textLabel attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.lodingImageView attribute:NSLayoutAttributeTrailing multiplier:1 constant:10];
            NSLayoutConstraint *t_centerY = [NSLayoutConstraint constraintWithItem:self.textLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.backgroundView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
            NSLayoutConstraint *t_width = [NSLayoutConstraint constraintWithItem:self.textLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1 constant:TextW];
            NSLayoutConstraint *t_height = [NSLayoutConstraint constraintWithItem:self.textLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:TextH];
            [self.backgroundView addConstraints:@[t_leading, t_centerY, t_width, t_height]];
        }
            break;
        case WDLoadingHUDImageDirectionRight:{
            self.textLabel.textAlignment = NSTextAlignmentLeft;

            rect = [title boundingRectWithSize:CGSizeMake(UIScreen.mainScreen.bounds.size.width * 0.35, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:self.textLabel.font} context:nil];
            
            CGFloat TextH = rect.size.height;
            
            if (rect.size.width >= UIScreen.mainScreen.bounds.size.width / 5 && rect.size.width <= UIScreen.mainScreen.bounds.size.width * 0.35){
                TextW = rect.size.width;
            } else if (rect.size.width < UIScreen.mainScreen.bounds.size.width / 5){
                TextW = UIScreen.mainScreen.bounds.size.width / 5;
            } else {
                TextW = UIScreen.mainScreen.bounds.size.width * 0.35;
            }
            
            NSLayoutConstraint *c_centerX = [NSLayoutConstraint constraintWithItem:self.backgroundView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
            NSLayoutConstraint *c_centerY = [NSLayoutConstraint constraintWithItem:self.backgroundView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
            NSLayoutConstraint *c_width = [NSLayoutConstraint constraintWithItem:self.backgroundView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1 constant:TextW + imageSize.width + 20];
            NSLayoutConstraint *c_height;
            if ((TextH + 20) > imageSize.height) {
                c_height = [NSLayoutConstraint constraintWithItem:self.backgroundView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:TextH + 30];
            } else {
                c_height = [NSLayoutConstraint constraintWithItem:self.backgroundView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:imageSize.height + 30];
            }
            
            [self.containerView addConstraints:@[c_centerX, c_centerY, c_width, c_height]];
            
            NSLayoutConstraint *t_leading = [NSLayoutConstraint constraintWithItem:self.textLabel attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.backgroundView attribute:NSLayoutAttributeLeading multiplier:1 constant:10];
            NSLayoutConstraint *t_centerY = [NSLayoutConstraint constraintWithItem:self.textLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.backgroundView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
            NSLayoutConstraint *t_width = [NSLayoutConstraint constraintWithItem:self.textLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1 constant:TextW];
            NSLayoutConstraint *t_height = [NSLayoutConstraint constraintWithItem:self.textLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:TextH];
            [self.backgroundView addConstraints:@[t_leading, t_centerY, t_width, t_height]];
            
            NSLayoutConstraint *img_centerY = [NSLayoutConstraint constraintWithItem:self.lodingImageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.backgroundView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
            NSLayoutConstraint *img_triling = [NSLayoutConstraint constraintWithItem:self.lodingImageView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.backgroundView attribute:NSLayoutAttributeTrailing multiplier:1 constant:-10];
            [self.backgroundView addConstraints:@[img_centerY, img_triling]];
        }
            break;
        case WDLoadingHUDImageDirectionBottom:{
            CGFloat TextH = rect.size.height;
            self.textLabel.textAlignment = NSTextAlignmentCenter;
            if (rect.size.width >= UIScreen.mainScreen.bounds.size.width / 5 && rect.size.width <= UIScreen.mainScreen.bounds.size.width * 0.7){
                TextW = rect.size.width;
            } else if (rect.size.width < UIScreen.mainScreen.bounds.size.width / 5){
                TextW = UIScreen.mainScreen.bounds.size.width / 5;
            } else {
                TextW = UIScreen.mainScreen.bounds.size.width * 0.7;
            }
            
            NSLayoutConstraint *c_centerX = [NSLayoutConstraint constraintWithItem:self.backgroundView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
            NSLayoutConstraint *c_centerY = [NSLayoutConstraint constraintWithItem:self.backgroundView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
            NSLayoutConstraint *c_width = [NSLayoutConstraint constraintWithItem:self.backgroundView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1 constant:TextW + imageSize.width + 20];
            NSLayoutConstraint *c_height =  [NSLayoutConstraint constraintWithItem:self.backgroundView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:TextH + 20 + imageSize.height + 10];
            [self.containerView addConstraints:@[c_centerX, c_centerY, c_width, c_height]];
            
            NSLayoutConstraint *t_top = [NSLayoutConstraint constraintWithItem:self.textLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.backgroundView attribute:NSLayoutAttributeTop multiplier:1 constant:10];
            NSLayoutConstraint *t_centerX = [NSLayoutConstraint constraintWithItem:self.textLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.backgroundView attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
            NSLayoutConstraint *t_width = [NSLayoutConstraint constraintWithItem:self.textLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1 constant:TextW];
            [self.backgroundView addConstraints:@[t_top, t_centerX, t_width]];
            
            NSLayoutConstraint *img_top = [NSLayoutConstraint constraintWithItem:self.lodingImageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.textLabel attribute:NSLayoutAttributeBottom multiplier:1 constant:10];
            NSLayoutConstraint *img_centerX = [NSLayoutConstraint constraintWithItem:self.lodingImageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.backgroundView attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
            [self.backgroundView addConstraints:@[img_centerX, img_top]];
        }
            break;
        default:
            break;
    }
    
    // 颜色设置
    if (style == WDLoadingHUDColorStyleLight) {
        self.backgroundView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.9];
        self.textLabel.textColor = UIColor.darkGrayColor;
        self.lodingImageView.tintColor = UIColor.darkGrayColor;
    } else {
        self.backgroundView.backgroundColor = UIColor.darkGrayColor;
        self.textLabel.textColor = UIColor.whiteColor;
        self.lodingImageView.tintColor = UIColor.whiteColor;
    }
}

#pragma - 获取window
- (UIWindow*)lastWindow {
    NSEnumerator*frontToBackWindows = [UIApplication.sharedApplication.windows reverseObjectEnumerator];
    for(UIWindow *window in frontToBackWindows) {
        BOOL windowOnMainScreen = window.screen==UIScreen.mainScreen;
        BOOL windowIsVisible = !window.hidden && window.alpha>0;
        BOOL windowLevelSupported = (window.windowLevel>=UIWindowLevelNormal&& window.windowLevel<=UIWindowLevelNormal);
        BOOL windowKeyWindow = window.isKeyWindow;
        if(windowOnMainScreen && windowIsVisible && windowLevelSupported && windowKeyWindow) {
            return window;
        }
    }
    return [UIApplication sharedApplication].keyWindow;
}

#pragma - 显示Loding
- (void)showHUD {

    [self dismissHUD];
    
    self.frame = UIScreen.mainScreen.bounds;
    [UIApplication.sharedApplication.delegate.window addSubview:self];
    self.containerView = [[UIView alloc] init];
    self.containerView.frame = UIScreen.mainScreen.bounds;
    [self addSubview:self.containerView];
}

#pragma - 移除Loding
- (void)dismissHUD {
    
    for (NSLayoutConstraint *constraint in self.backgroundView.constraints) {
        [self.backgroundView removeConstraint:constraint];
    }
    
    for (UIView *view in self.backgroundView.subviews) {
        [view removeFromSuperview];
    }
    
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    
    
    
    [self removeFromSuperview];
}

#pragma mark =============== Getter ===============
- (UIView *)backgroundView {
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc] init];
    }
    return _backgroundView;
}

- (UILabel *)textLabel {
    if(!_textLabel) {
        _textLabel = [[UILabel alloc] init];
        _textLabel.numberOfLines = 0;
    }
    return _textLabel;
}

- (UIImageView *)lodingImageView {
    if (!_lodingImageView) {
        _lodingImageView = [[UIImageView alloc] init];
        _lodingImageView.contentMode = UIViewContentModeScaleToFill;
    }
    return _lodingImageView;
}

- (UIActivityIndicatorView *)indicatorView {
    if (!_indicatorView) {
        _indicatorView = [[UIActivityIndicatorView alloc] init];
        _indicatorView.transform = CGAffineTransformMakeScale(3, 3);
    }
    return _indicatorView;
}

@end
