//
//  WDLoadingHUD.h
//  WDMediaPlayer
//
//  Created by wudan on 2018/9/27.
//  Copyright © 2018 wudan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, WDLoadingHUDColorStyle) {
    WDLoadingHUDColorStyleDefault,
    WDLoadingHUDColorStyleLight,
};

typedef NS_ENUM(NSInteger, WDLoadingHUDImageDirection) {
    WDLoadingHUDImageDirectionLeft,
    WDLoadingHUDImageDirectionRight,
    WDLoadingHUDImageDirectionTop,
    WDLoadingHUDImageDirectionBottom,
};


@interface WDLoadingHUD : UIView

+ (instancetype)hud;

/**
 显示系统小菊花

 @param style style 显示样式《深色、亮色》
 */
- (void)showNormalIndicatorWithStyle:(WDLoadingHUDColorStyle)style;

/**
 仅显示文字

 @param title 显示内容
 @param style style 显示样式《深色、亮色》
 */
- (void)showNormalTitle:(NSString *)title style:(WDLoadingHUDColorStyle)style;

/**
 显示文字和单图

 @param title 标题
 @param imageName 图片名称
 @param aDirection 图片显示方向
 @param style style 显示样式《深色、亮色》
 */
- (void)showTitle:(NSString *)title imageName:(NSString *)imageName direction:(WDLoadingHUDImageDirection)aDirection style:(WDLoadingHUDColorStyle)style;

- (void)showImageAnimationWithImageArray:(NSArray<NSString *> *)imageArray duration:(CGFloat)time style:(WDLoadingHUDColorStyle)style;

- (void)dismissHUD;

@end

NS_ASSUME_NONNULL_END
