//
//  WDDropDownView.m
//  iOS-Demo
//
//  Created by 吴丹 on 2018/9/7.
//  Copyright © 2018 forever.love. All rights reserved.
//

#import "WDDropDownView.h"

typedef enum : NSUInteger {
    WDDropDownButtonStyle_RightImage,
    WDDropDownButtonStyle_LeftImage,
} WDDropDownButtonStyle;

@interface WDDropDownButton : UIButton

- (void)wd_layoutButtonWithEdgeInsetsStyle:(WDDropDownButtonStyle)style
                           imageTitleSpace:(CGFloat)space;

@end

@implementation WDDropDownButton

- (void)wd_layoutButtonWithEdgeInsetsStyle:(WDDropDownButtonStyle)style
                           imageTitleSpace:(CGFloat)space {
    CGFloat imageWith = self.imageView.frame.size.width;
    
    CGFloat labelWidth = 0.0;
    CGFloat labelHeight = 0.0;
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        labelWidth = self.titleLabel.intrinsicContentSize.width;
        labelHeight = self.titleLabel.intrinsicContentSize.height;
    } else {
        labelWidth = self.titleLabel.frame.size.width;
        labelHeight = self.titleLabel.frame.size.height;
    }
    
    UIEdgeInsets imageEdgeInsets = UIEdgeInsetsZero;
    UIEdgeInsets labelEdgeInsets = UIEdgeInsetsZero;
    
    switch (style) {
        case WDDropDownButtonStyle_LeftImage:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, -space / 2.0, 0, space / 2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, space / 2.0, 0, -space / 2.0);
        }
            break;
        case WDDropDownButtonStyle_RightImage:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth + space / 2.0, 0, -labelWidth - space / 2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith - space / 2.0, 0, imageWith + space / 2.0);
        }
            break;
        default:
            break;
    }
    
    self.titleEdgeInsets = labelEdgeInsets;
    self.imageEdgeInsets = imageEdgeInsets;
}
@end

#define WD_SCR_WIDTH UIScreen.mainScreen.bounds.size.width
#define WD_SCR_HEIGHT UIScreen.mainScreen.bounds.size.height

NSString * const WDchangeTitle = @"wd_changeTitle";

@interface WDDropDownView  ()

@property (nonatomic, strong) UIView *headerButtonView;
@property (nonatomic, strong) UIButton *converButton;
@property (nonatomic, strong) UIView *bottomLine;
@property (nonatomic, strong) UIButton *lastSelectedButton;

@end

@implementation WDDropDownView

- (instancetype)initWithTitleArray:(NSArray<NSString *> *)titleArray controllerArray:(NSArray<UIViewController *> *)controllerArray controllerHeightArray:(NSArray *)controllerHeightArray {
    self = [super init];
    if(self){
        self.lastSelectedButton = UIButton.new;
        self.titleArray = titleArray;
        self.controllerArray = controllerArray;
        self.controllerHeightArray = controllerHeightArray;
    }
    return self;
}

- (instancetype)init{
    
    self = [super init];
    if(self){
        self.lastSelectedButton = UIButton.new;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dealWithNotification:) name:WDchangeTitle object:nil];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)layoutSubviews {
    
    [self addSubview:self.headerButtonView];
    [self addSubview:self.bottomLine];
    
    [self insetButton];
}

- (void)dealWithNotification:(NSNotification *)notification {
    
    if (![self.controllerArray containsObject:notification.object]) {
        return;
    }
    
    [self converButtonDismiss];
    NSArray *allValues = notification.userInfo.allValues;
    [self.lastSelectedButton setTitle:allValues.firstObject forState:UIControlStateNormal];
}

- (void)setControllerHeightArray:(NSArray *)controllerHeightArray{
    _controllerHeightArray = controllerHeightArray;
}

- (void)setControllerArray:(NSArray<UIViewController *> *)controllerArray {
    _controllerArray = controllerArray;
}

- (void)setTitleArray:(NSArray<NSString *> *)titleArray {
    _titleArray = titleArray;
}

- (void)insetButton{
    
    if (self.titleArray.count != self.controllerArray.count) {
        @throw [NSException exceptionWithName:NSStringFromClass(self.class) reason:@"标题和控制器数量不对应" userInfo:nil];
    }
    
    CGFloat Width = WD_SCR_WIDTH/self.titleArray.count;
    for (int i=0; i<self.titleArray.count; i++) {
        WDDropDownButton *b = [[WDDropDownButton alloc] init];
        [b setTitle:self.titleArray[i] forState:UIControlStateNormal];
        [b setImage:[UIImage imageNamed:@"arrow_down"] forState:UIControlStateNormal];
        [b setImage:[UIImage imageNamed:@"arrow_up"] forState:UIControlStateSelected];
        [b setTitleColor:UIColor.lightGrayColor forState:UIControlStateNormal];
        [b setTitleColor:UIColor.orangeColor forState:UIControlStateSelected];
        b.frame = CGRectMake(Width * i, 0, Width, self.frame.size.height);
        b.tag = i + 1;
//        [b wd_layoutButtonWithEdgeInsetsStyle:WDDropDownButtonStyle_RightImage imageTitleSpace:0];
        [b addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.headerButtonView addSubview:b];
    }
}

- (void)buttonAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    if (self.lastSelectedButton && self.lastSelectedButton != sender) {
        self.lastSelectedButton.selected = NO;
    }
    
    self.lastSelectedButton = sender;
    
    if (self.lastSelectedButton.selected) {
        [self converButtonShowWithTag:sender.tag-1];
    } else {
        [self converButtonDismiss];
    }
}

#pragma mark =============== 页面显示 ===============
- (void)converButtonShowWithTag:(NSInteger)tag{
    for(UIView *view in self.converButton.subviews){
        [view removeFromSuperview];
    }
    UIViewController *currentVC = self.controllerArray[tag];
    self.converButton.alpha = 0;
    self.converButton.frame = CGRectMake(0, self.headerButtonView.frame.size.height+self.frame.origin.y+1, WD_SCR_WIDTH, 0);
    currentVC.view.frame = CGRectMake(0, 0, WD_SCR_WIDTH, 0);
    
    [UIView animateWithDuration:0.3f animations:^{
        self.converButton.alpha = 1;
        self.converButton.frame = CGRectMake(0, self.headerButtonView.frame.size.height+self.frame.origin.y+1, WD_SCR_WIDTH, WD_SCR_HEIGHT-self.headerButtonView.frame.size.height);
        currentVC.view.frame = CGRectMake(0, 0, WD_SCR_WIDTH, [self.controllerHeightArray[tag] floatValue]);
    } completion:^(BOOL finished) {
        [self.superview addSubview:self.converButton];
        [self.converButton addSubview:currentVC.view];
    }];
}

#pragma mark =============== 页面消失 ===============
- (void)converButtonDismiss {
    self.lastSelectedButton.selected = false;
    
    [UIView animateWithDuration:0.3f animations:^{
        self.converButton.alpha = 0;
        self.converButton.frame = CGRectMake(0, self.headerButtonView.frame.size.height+self.frame.origin.y+1, WD_SCR_WIDTH, 0);
    } completion:^(BOOL finished) {
        [self.converButton removeFromSuperview];
    }];
}

#pragma mark =============== Getter ===============

- (UIView *)headerButtonView {
    if (!_headerButtonView) {
        _headerButtonView = ({
            UIView *v = [[UIView alloc] init];
            v.backgroundColor = UIColor.whiteColor;
            v.frame = CGRectMake(0, 0, WD_SCR_WIDTH, self.frame.size.height);
            v;
        });
    }
    return _headerButtonView;
}

- (UIButton *)converButton {
    if (!_converButton) {
        _converButton = ({
            UIButton *b = [UIButton buttonWithType:UIButtonTypeCustom];
            b.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
            [b addTarget:self action:@selector(converButtonDismiss) forControlEvents:UIControlEventTouchUpInside];
            b;
        });
    }
    return _converButton;
}

- (UIView *)bottomLine {
    if (!_bottomLine) {
        _bottomLine = ({
            UIView *v = [[UIView alloc] init];
            v.backgroundColor = UIColor.lightGrayColor;
            v.frame = CGRectMake(0, self.frame.size.height-0.5, WD_SCR_WIDTH, 0.5);
            v;
        });
    }
    return _bottomLine;
}
@end
