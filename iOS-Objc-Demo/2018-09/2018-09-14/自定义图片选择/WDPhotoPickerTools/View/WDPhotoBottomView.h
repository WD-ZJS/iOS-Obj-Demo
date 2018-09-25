//
//  WDPhotoBottomView.h
//  WDPhotoPick
//
//  Created by 吴丹 on 2018/9/13.
//  Copyright © 2018 forever.love. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WDPhotoBottomView : UIView

@property (nonatomic, strong) UIButton *sureButton;
@property (nonatomic, strong) UIButton *backButton;

@property (nonatomic, copy) void (^sureButtonBlock)(void);

@end

NS_ASSUME_NONNULL_END
