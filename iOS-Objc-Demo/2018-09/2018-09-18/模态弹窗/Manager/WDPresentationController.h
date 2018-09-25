//
//  WDPresentationController.h
//  iOS-Objc-Demo
//
//  Created by 吴丹 on 2018/9/18.
//  Copyright © 2018 forever.love. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WDPopoverMacro.h"
NS_ASSUME_NONNULL_BEGIN

@interface WDPresentationController : UIPresentationController

@property(nonatomic, assign) CGSize           presentedSize;
@property(nonatomic, assign) CGFloat          presentedHeight;

@property(nonatomic, strong) UIView           *coverView;
@property(nonatomic, assign) WDPopoverType    popoverType;


@end

NS_ASSUME_NONNULL_END
