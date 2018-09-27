//
//  WDPageNavigationBar.h
//  NestingView
//
//  Created by wudan on 2018/9/27.
//  Copyright © 2018 wudan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WDPageNavigationBar : UIView

// 主视图
@property (nonatomic, strong) UIView    *mainView;
// 左边第一个按钮
@property (nonatomic, strong) UIButton  *leftButton;
// 左边第二个按钮
@property (nonatomic, strong) UIButton  *leftTwoButton;
// 右边第一个按钮
@property (nonatomic, strong) UIButton  *rightButton;
// 右边第二个按钮
@property (nonatomic, strong) UIButton  *rightTwoButton;
// 标题按钮
@property (nonatomic, strong) UIButton  *centerButton;
// 是否显示底部线
@property (nonatomic, assign) BOOL      showBottomLabel;

@property (nonatomic, copy) void (^ leftButtonBlock)(void);
@property (nonatomic, copy) void (^ leftTwoButtonBlock)(void);
@property (nonatomic, copy) void (^ cenTerButtonBlock)(void);
@property (nonatomic, copy) void (^ rightButtonBlock)(void);
@property (nonatomic, copy) void (^ rightTwoButtonBlock)(void);

@end

NS_ASSUME_NONNULL_END
