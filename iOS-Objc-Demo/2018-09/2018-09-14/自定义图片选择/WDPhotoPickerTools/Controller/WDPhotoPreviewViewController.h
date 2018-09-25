//
//  WDPhotoPreviewViewController.h
//  WDPhotoPick
//
//  Created by 吴丹 on 2018/9/14.
//  Copyright © 2018 forever.love. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WDPhotoImageModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface WDPhotoPreviewViewController : UIViewController
@property (nonatomic, strong) WDPhotoImageModel *model;

@property (nonatomic, copy) void (^isSelectedItemBlock)(WDPhotoImageModel *model);

@end

NS_ASSUME_NONNULL_END
