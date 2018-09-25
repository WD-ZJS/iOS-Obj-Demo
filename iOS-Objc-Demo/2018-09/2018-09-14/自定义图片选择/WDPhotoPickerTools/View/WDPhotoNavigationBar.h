//
//  WDPhotoNavigationBar.h
//  WDPhotoPick
//
//  Created by 吴丹 on 2018/9/13.
//  Copyright © 2018 forever.love. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WDPhotoNavigationBar : UIView

@property (nonatomic, strong) UILabel *centerLabel;
@property (nonatomic, strong) UIButton *cancelButton;

@property (nonatomic, copy) void (^cancelButtonBlock)(void);

@end

NS_ASSUME_NONNULL_END
