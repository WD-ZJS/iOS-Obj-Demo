//
//  WDPhotoPickerViewController.h
//  WDPhotoPick
//
//  Created by 吴丹 on 2018/9/13.
//  Copyright © 2018 forever.love. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WDPhotoPickerViewController : UIViewController

@property (nonatomic, copy) void (^userSelectedImageArray)(NSArray<UIImage *> * imageArray);
// 颜色配置
@property (nonatomic, strong) UIColor *navgationBarBackgrondColor;
@property (nonatomic, strong) UIColor *titleTextColor;
@property (nonatomic, strong) UIColor *cancelTextColor;
@property (nonatomic, strong) UIColor *sureBackgrondColor;
@property (nonatomic, strong) UIColor *sureTextColor;
// 导航栏样式
@property (nonatomic, assign) UIStatusBarStyle statusBarStyle;

@end

NS_ASSUME_NONNULL_END
