//
//  WDPhotoPickerManager.h
//  WDPhotoPick
//
//  Created by 吴丹 on 2018/9/13.
//  Copyright © 2018 forever.love. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "WDPhotoConfig.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^getImageArryBlock)(NSArray<UIImage *> * imageArray);

@interface WDPhotoPickerManager : NSObject

+ (instancetype)manager;

- (void)openUserPhotoAlbumInViewController:(UIViewController *)controller
                navgationBarBackgrondColor:(UIColor *)aNavgationBarBackgrondColor
                            titleTextColor:(UIColor *)aTitleTextColor
                           cancelTextColor:(UIColor *)aCancelTextColor
                        sureBackgrondColor:(UIColor *)aSureBackgrondColor
                             sureTextColor:(UIColor *)aSureTextColor
                            statusBarStyle:(UIStatusBarStyle)aStatusBarStyle
                            imageArryBlock:(void(^)(NSArray<UIImage *> * imageArray))anImageArrayBlock;

// 推荐使用
- (void)openUserPhotoAlbumInViewController:(UIViewController *)controller
                           photoPageConfig:(WDPhotoConfig *)config
                            imageArryBlock:(void(^)(NSArray<UIImage *> * imageArray))anImageArrayBlock;

@end

NS_ASSUME_NONNULL_END
