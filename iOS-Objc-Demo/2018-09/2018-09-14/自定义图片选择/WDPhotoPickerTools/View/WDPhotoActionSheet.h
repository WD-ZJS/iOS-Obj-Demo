//
//  WDPhotoActionSheet.h
//  WDPhotoPick
//
//  Created by 吴丹 on 2018/9/13.
//  Copyright © 2018 forever.love. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WDPhotoActionSheet : UIView

+ (instancetype)shareInstances;

- (void)setUIWithTitleArray:(NSArray<NSString *> *)titleArray
          cancelButtonTitle:(NSString *)cancelButtonTitle
         selectedIndexBlock:(void(^)(NSInteger index))aSelectedIndexBlock;
@end

NS_ASSUME_NONNULL_END
