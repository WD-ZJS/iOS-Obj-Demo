//
//  WDPageNavigationBar.m
//  NestingView
//
//  Created by wudan on 2018/9/27.
//  Copyright © 2018 wudan. All rights reserved.
//

#import "WDPageNavigationBar.h"

@interface WDPageNavigationBar ()

@property (nonatomic, strong) UILabel *lineLabel;
@property (nullable, nonatomic, readonly) UIViewController *viewController;

@end

@implementation WDPageNavigationBar

- (UIView *)mainView{
    if (!_mainView) {
        _mainView = [UIView new];
        _mainView.backgroundColor = [UIColor clearColor];
        [self addSubview:_mainView];
        _mainView.translatesAutoresizingMaskIntoConstraints = false;
        NSLayoutConstraint *img_top = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_mainView attribute:NSLayoutAttributeTop multiplier:1 constant:0];
        NSLayoutConstraint *img_left = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_mainView attribute:NSLayoutAttributeLeft multiplier:1 constant:0];
        NSLayoutConstraint *img_right = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:_mainView attribute:NSLayoutAttributeRight multiplier:1 constant:0];
        NSLayoutConstraint *img_bottom = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_mainView attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
        [self addConstraints:@[img_top, img_left, img_right, img_bottom]];

        [_mainView.superview layoutIfNeeded];
    }
    return _mainView;
}

- (UIButton *)leftButton{
    if (!_leftButton) {
        // 左边按钮
        _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftButton.titleLabel.font = [UIFont systemFontOfSize:15];
        _leftButton.adjustsImageWhenHighlighted = NO;
        _leftButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [_leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.mainView addSubview:_leftButton];
        [_leftButton addTarget:self action:@selector(clickLeftButton) forControlEvents:UIControlEventTouchUpInside];
        
        _leftButton.translatesAutoresizingMaskIntoConstraints = false;
        NSLayoutConstraint *img_centerY = [NSLayoutConstraint constraintWithItem:_leftButton attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.mainView attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
        NSLayoutConstraint *img_left = [NSLayoutConstraint constraintWithItem:_leftButton attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.mainView attribute:NSLayoutAttributeLeft multiplier:1 constant:15];
        NSLayoutConstraint *img_height = [NSLayoutConstraint constraintWithItem:_leftButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:40];
        [self.mainView addConstraints:@[img_centerY, img_left, img_height]];
    }
    return _leftButton;
}

- (UIButton *)leftTwoButton{
    if (!_leftTwoButton) {
        // 左边第二个按钮
        _leftTwoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftTwoButton.titleLabel.font = [UIFont systemFontOfSize:15];
        _leftTwoButton.adjustsImageWhenHighlighted = NO;
        _leftTwoButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [_leftTwoButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.mainView addSubview:_leftTwoButton];
        [_leftTwoButton addTarget:self action:@selector(clickLeftTwoButton) forControlEvents:UIControlEventTouchUpInside];
        
        _leftTwoButton.translatesAutoresizingMaskIntoConstraints = false;
        NSLayoutConstraint *img_centerY = [NSLayoutConstraint constraintWithItem:_leftTwoButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.leftButton attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
        NSLayoutConstraint *img_left = [NSLayoutConstraint constraintWithItem:_leftTwoButton attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.leftButton attribute:NSLayoutAttributeRight multiplier:1 constant:10];
        NSLayoutConstraint *img_height = [NSLayoutConstraint constraintWithItem:_leftTwoButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:40];
        [self.mainView addConstraints:@[img_centerY, img_left, img_height]];
    }
    return _leftTwoButton;
}

-(UIButton *)rightButton{
    if (!_rightButton) {
        //右边按钮
        UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        rightButton.titleLabel.font = [UIFont systemFontOfSize:15];
        rightButton.adjustsImageWhenHighlighted = NO;
        [rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.mainView addSubview:rightButton];
        self.rightButton = rightButton;
        [_rightButton addTarget:self action:@selector(clickRightButton) forControlEvents:UIControlEventTouchUpInside];
        
        _rightButton.translatesAutoresizingMaskIntoConstraints = false;
        NSLayoutConstraint *img_centerY = [NSLayoutConstraint constraintWithItem:_rightButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.leftButton attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
        NSLayoutConstraint *img_right = [NSLayoutConstraint constraintWithItem:_rightButton attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.mainView attribute:NSLayoutAttributeRight multiplier:1 constant:-5];
        NSLayoutConstraint *img_height = [NSLayoutConstraint constraintWithItem:_rightButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:40];
        [self.mainView addConstraints:@[img_centerY, img_right, img_height]];
        
        [self.rightButton.superview layoutIfNeeded];
    }
    return _rightButton;
}

-(UIButton *)rightTwoButton{
    if (!_rightTwoButton) {
        //右边第二个按钮
        UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        rightButton.titleLabel.font = [UIFont systemFontOfSize:15];
        rightButton.adjustsImageWhenHighlighted = NO;
        [rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.mainView addSubview:rightButton];
        self.rightTwoButton = rightButton;
        [_rightTwoButton addTarget:self action:@selector(clickRightTwoButton) forControlEvents:UIControlEventTouchUpInside];
        _rightTwoButton.translatesAutoresizingMaskIntoConstraints = false;
        NSLayoutConstraint *img_centerY = [NSLayoutConstraint constraintWithItem:_rightTwoButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.leftButton attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
        NSLayoutConstraint *img_right = [NSLayoutConstraint constraintWithItem:_rightTwoButton attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.rightButton attribute:NSLayoutAttributeLeft multiplier:1 constant:-10];
        NSLayoutConstraint *img_height = [NSLayoutConstraint constraintWithItem:_rightTwoButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:40];
        [self.mainView addConstraints:@[img_centerY, img_right, img_height]];
        
        [self.rightTwoButton.superview layoutIfNeeded];
    }
    return _rightTwoButton;
}

-(UIButton *)centerButton{
    if (!_centerButton) {
        //中间按钮
        UIButton *centerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        centerButton.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        [centerButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        centerButton.adjustsImageWhenHighlighted = NO;
        [self.mainView addSubview:centerButton];
        self.centerButton = centerButton;
        [_centerButton addTarget:self action:@selector(clickCenterButton) forControlEvents:UIControlEventTouchUpInside];
        
        _centerButton.translatesAutoresizingMaskIntoConstraints = false;
        NSLayoutConstraint *centerX = [NSLayoutConstraint constraintWithItem:_centerButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.mainView attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
        NSLayoutConstraint *centerY = [NSLayoutConstraint constraintWithItem:_centerButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.leftButton attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
        NSLayoutConstraint *img_height = [NSLayoutConstraint constraintWithItem:_centerButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:40];
        [self.mainView addConstraints:@[centerX, centerY, img_height]];
        
        [self.centerButton.superview layoutIfNeeded];
    }
    return _centerButton;
}

-(UILabel *)lineLabel{
    if (!_lineLabel) {
        //底部分割线
        UILabel *lineLabel = [[UILabel alloc] init];
        lineLabel.backgroundColor = UIColor.lightGrayColor;
        self.lineLabel = lineLabel;
        [self.mainView addSubview:lineLabel];

        lineLabel.translatesAutoresizingMaskIntoConstraints = false;
        NSLayoutConstraint *centerX = [NSLayoutConstraint constraintWithItem:lineLabel attribute:NSLayoutAttributeLeft|NSLayoutAttributeRight|NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.mainView attribute:NSLayoutAttributeLeft|NSLayoutAttributeRight|NSLayoutAttributeRight multiplier:1 constant:0];
        NSLayoutConstraint *img_height = [NSLayoutConstraint constraintWithItem:lineLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:1];
        [self.mainView addConstraints:@[centerX, img_height]];
        
        [self.mainView bringSubviewToFront:lineLabel];
    }
    return _lineLabel;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupUI];
    }
    return self;
}

/**
 *  UI 界面
 */
- (void)setupUI{
    [self lineLabel];
}

- (void)setShowBottomLabel:(BOOL)showBottomLabel{
    self.lineLabel.hidden = !showBottomLabel;
}
- (UIViewController *)viewController {
    for (UIView *view = self; view; view = view.superview) {
        UIResponder *nextResponder = [view nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

#pragma mark - private
- (void)clickLeftButton{
    //  获取返回视图的视图控制器
    [self.viewController.navigationController popViewControllerAnimated:YES];
    if (self.leftButtonBlock) {
        self.leftButtonBlock();
    }
}

- (void)clickLeftTwoButton{
    if (self.leftTwoButtonBlock) {
        self.leftTwoButtonBlock();
    }
}


- (void)clickCenterButton{
    if (self.cenTerButtonBlock) {
        self.cenTerButtonBlock();
    }
}

- (void)clickRightButton{
    if (self.rightButtonBlock) {
        self.rightButtonBlock();
    }
}

- (void)clickRightTwoButton{
    if (self.rightTwoButtonBlock) {
        self.rightTwoButtonBlock();
    }
}


@end
