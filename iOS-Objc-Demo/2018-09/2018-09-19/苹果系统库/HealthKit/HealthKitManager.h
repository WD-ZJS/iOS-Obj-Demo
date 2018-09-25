//
//  HealthKitManager.h
//  iOS-Objc-Demo
//
//  Created by 吴丹 on 2018/9/19.
//  Copyright © 2018 forever.love. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HealthKitManager : NSObject

+ (instancetype)mamager;

/**
 获取系统总步数

 @param stepBlock 获取步数
 */
- (void)requsetStepInfoWithStepBlock:(void(^)(int stepNum))stepBlock;
/**
 开始计步器

 @param stepBlock 获取步数
 */
- (void)requsetCalculationStepWithStepBlock:(void (^)(int stepCount , int distance))stepBlock;
/**
 关闭计步器
 */
- (void)endCalculationStep;

@end

NS_ASSUME_NONNULL_END
