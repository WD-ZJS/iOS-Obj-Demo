//
//  WDImagePickerTools.h
//  WDPhotoPick
//
//  Created by 吴丹 on 2018/9/11.
//  Copyright © 2018 forever.love. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WDImagePickerTools : NSObject

- (void)oepenImageBorrowwWithScuuessBlock:(void(^)(NSArray *imageArray))successBlock failBlock:(void(^)(void))aFailBlock;

@end

NS_ASSUME_NONNULL_END
