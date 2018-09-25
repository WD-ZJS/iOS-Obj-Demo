//
//  WDPopoverPresentationManager.h
//  iOS-Objc-Demo
//
//  Created by 吴丹 on 2018/9/18.
//  Copyright © 2018 forever.love. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WDPopoverPresentationManager : NSObject
/**
 设置系统popovera弹窗

 @param fromController 需要弹窗控制器
 @param aPresentedController 弹窗控制器
 @param aBackgroundColor 弹出视图的背景颜色
 @param aPreferredContentSize 弹窗视图尺寸 可以为空
 @param aSourceView 参照视图
 @param aSourceRect 设置弹出视图的位置
 @param aPermittedArrowDirections 箭头的方向 设置成UIPopoverArrowDirectionAny 会自动转换方向
 */
- (void)setupPopoverPresentationWithFromController:(UIViewController *)fromController
                               presentedController:(UIViewController *)aPresentedController
                                   backgroundColor:(UIColor *)aBackgroundColor
                              preferredContentSize:(CGSize)aPreferredContentSize
                                        sourceView:(UIView *)aSourceView
                                        sourceRect:(CGRect)aSourceRect
                          permittedArrowDirections:(UIPopoverArrowDirection)aPermittedArrowDirections;
@end

NS_ASSUME_NONNULL_END
