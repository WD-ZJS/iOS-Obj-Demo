//
//  WDActionSheet.h
//  iOS-Demo
//
//  Created by 吴丹 on 2018/9/7.
//  Copyright © 2018 forever.love. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WDActionSheet;

@protocol WDActionSheetDelegate

- (void)selectedIndex:(NSInteger)index;

@end

@interface WDActionSheet : UIView

@property (nonatomic, weak) id <WDActionSheetDelegate> delegate;

// 单例
+ (instancetype)shareInstances;

/**
 初始化ActionSheet
 
 @param titleArray 标题文字数组---不能为空
 @param cancelButtonTitle 取消按钮文字---可以为空
 @param selectDelegate 代理
 */
- (void)setUIWithTitleArray:(NSArray<NSString *> *)titleArray
          cancelButtonTitle:(NSString *)cancelButtonTitle
             selectDelegate:(id <WDActionSheetDelegate>)selectDelegate;

@end
