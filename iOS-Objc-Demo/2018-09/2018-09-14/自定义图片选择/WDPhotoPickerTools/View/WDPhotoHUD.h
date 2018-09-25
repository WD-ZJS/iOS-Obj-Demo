//
//  WDPhotoHUD.h
//  WDPhotoPick
//
//  Created by 吴丹 on 2018/9/13.
//  Copyright © 2018 forever.love. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WDPhotoHUD : UIView

+ (instancetype)hud;

- (void)showViewWithindicatorViewWithRemindText:(NSString *)remindText;

- (void)dismissView;

@end

NS_ASSUME_NONNULL_END
