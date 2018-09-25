//
//  DNPedometerManager.h
//  DNPedometer
//
//  Created by zjs on 2018/9/19.
//  Copyright © 2018年 zjs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DNPedometerManager : NSObject

+ (instancetype)defaultManager;

- (void)dn_startCalculatorStep:(void(^)(NSString *steps, NSString *distance))handler;

- (void)dn_stopCalculatorStep;

@end

NS_ASSUME_NONNULL_END
