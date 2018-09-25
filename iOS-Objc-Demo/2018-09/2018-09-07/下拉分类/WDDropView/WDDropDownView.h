//
//  WDDropDownView.h
//  iOS-Demo
//
//  Created by 吴丹 on 2018/9/7.
//  Copyright © 2018 forever.love. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

extern NSString * const WDchangeTitle;

@interface WDDropDownView : UIView

@property (nonatomic, strong) NSArray<NSString *> *titleArray;

@property (nonatomic, strong) NSArray<UIViewController *> *controllerArray;

@property (nonatomic, strong) NSArray *controllerHeightArray;

- (instancetype)initWithTitleArray:(NSArray<NSString *> *)titleArray
                   controllerArray:(NSArray<UIViewController *> *)controllerArray
             controllerHeightArray:(NSArray *)controllerHeightArray;
@end

NS_ASSUME_NONNULL_END
