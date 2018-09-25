//
//  WDPhotoImageCollectionViewCell.h
//  WDPhotoPick
//
//  Created by 吴丹 on 2018/9/13.
//  Copyright © 2018 forever.love. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WDPhotoImageModel.h"

NS_ASSUME_NONNULL_BEGIN

@class WDPhotoImageCollectionViewCell;

@protocol WDPhotoImageCollectionViewCellDelegate <NSObject>

- (void)photoSelectedAtCell:(WDPhotoImageCollectionViewCell *)cell;

@end

@interface WDPhotoImageCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) WDPhotoImageModel *model;

@property (nonatomic, weak) id <WDPhotoImageCollectionViewCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
