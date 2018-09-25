//
//  WDPhotoImageModel.h
//  WDPhotoPick
//
//  Created by 吴丹 on 2018/9/13.
//  Copyright © 2018 forever.love. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface WDPhotoImageModel : NSObject

@property (nonatomic, assign) BOOL isSelected;
@property (nonatomic, strong) UIImage *image;

@end

NS_ASSUME_NONNULL_END
