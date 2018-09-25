//
//  HealthKitManager.m
//  iOS-Objc-Demo
//
//  Created by 吴丹 on 2018/9/19.
//  Copyright © 2018 forever.love. All rights reserved.
//

#import "HealthKitManager.h"
#import <HealthKit/HealthKit.h>
#import <CoreMotion/CoreMotion.h>

@interface HealthKitManager ()

@property (nonatomic, strong) HKHealthStore *healthStore;
@property (nonatomic, strong) CMPedometer *stepPedometer;
@property (nonatomic, strong) CMPedometer *stepCounter;

@end

@implementation HealthKitManager

+ (instancetype)mamager {
    static dispatch_once_t onceToken;
    static HealthKitManager *manager;
    dispatch_once(&onceToken, ^{
        manager = [[HealthKitManager alloc] init];
    });
    
    return manager;
}

#pragma mark =============== 开始计步 ===============
- (void)requsetCalculationStepWithStepBlock:(void (^)(int stepCount , int distance))stepBlock  {
    
    if (![CMPedometer isStepCountingAvailable]) {
        NSLog(@"计步器不可用");
        return;
    }
    
    NSLog(@"开始计步");
    
    self.stepPedometer = [[CMPedometer alloc] init];
    
    NSDate *toDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *fromDate =
    [dateFormatter dateFromString:[dateFormatter stringFromDate:toDate]];
    
    [self.stepPedometer startPedometerUpdatesFromDate:fromDate withHandler:^(CMPedometerData * _Nullable pedometerData, NSError * _Nullable error) {
        if (!error) {
            stepBlock(pedometerData.numberOfSteps.intValue, pedometerData.distance.intValue);
        } else {
            NSLog(@"---%@",error);
        }
    }];
}

#pragma mark =============== 结束计步 ===============
- (void)endCalculationStep {
    NSLog(@"结束计步");
    [self.stepPedometer stopPedometerUpdates];
}

#pragma mark =============== 获取步数 ===============
- (void)requsetStepInfoWithStepBlock:(void(^)(int stepNum))stepBlock {
    if (![HKHealthStore isHealthDataAvailable]) {
        NSLog(@"该设备不支持HealthKit");
        return;
    }
    
    NSSet *shareType = [NSSet setWithObject:[HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount]];
    NSSet *readType = [NSSet setWithObject:[HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount]];
    
    [self.healthStore requestAuthorizationToShareTypes:shareType readTypes:readType completion:^(BOOL success, NSError * _Nullable error) {
        if (success) {
            [self readStepCountWithStepBlock:^(int stepNum) {
                stepBlock(stepNum);
            }];
        } else {
            NSLog(@"获取步数权限失败");
        }
    }];
}

#pragma mark 读取步数 查询数据
- (void)readStepCountWithStepBlock:(void(^)(int stepNum))stepBlock {
    //查询采样信息
    HKSampleType *sampleType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    //NSSortDescriptor来告诉healthStore怎么样将结果排序
    NSSortDescriptor *start = [NSSortDescriptor sortDescriptorWithKey:HKSampleSortIdentifierStartDate ascending:NO];
    NSSortDescriptor *end = [NSSortDescriptor sortDescriptorWithKey:HKSampleSortIdentifierEndDate ascending:NO];
    //获取当前时间
    NSDate *now = [NSDate date];
    NSCalendar *calender = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dateComponent = [calender components:unitFlags fromDate:now];
    int hour = (int)[dateComponent hour];
    int minute = (int)[dateComponent minute];
    int second = (int)[dateComponent second];
    NSDate *nowDay = [NSDate dateWithTimeIntervalSinceNow:  - (hour*3600 + minute * 60 + second) ];
    NSDate *nextDay = [NSDate dateWithTimeIntervalSinceNow:  - (hour*3600 + minute * 60 + second)  + 86400];
    NSPredicate *predicate = [HKQuery predicateForSamplesWithStartDate:nowDay endDate:nextDay options:(HKQueryOptionNone)];
    
    HKSampleQuery *sampleQuery = [[HKSampleQuery alloc]initWithSampleType:sampleType predicate:predicate limit:0 sortDescriptors:@[start,end] resultsHandler:^(HKSampleQuery * _Nonnull query, NSArray<__kindof HKSample *> * _Nullable results, NSError * _Nullable error) {
        int allStepCount = 0;
        for (int i = 0; i < results.count; i ++) {
            HKQuantitySample *result = results[i];
            HKQuantity *quantity = result.quantity;
            NSMutableString *stepCount = (NSMutableString *)quantity;
            NSString *stepStr =[ NSString stringWithFormat:@"%@",stepCount];
            NSString *str = [stepStr componentsSeparatedByString:@" "][0];
            int stepNum = [str intValue];
            allStepCount = allStepCount + stepNum;
        }
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            stepBlock(allStepCount);
        }];
    }];
    //执行查询
    [self.healthStore executeQuery:sampleQuery];
}

#pragma mark =============== Getter ===============
- (HKHealthStore *)healthStore {
    if (!_healthStore) {
        _healthStore = [[HKHealthStore alloc] init];
    }
    return _healthStore;
}

- (CMPedometer *)stepPedometer {
    if (!_stepPedometer) {
        _stepPedometer = [[CMPedometer alloc] init];
    }
    return _stepPedometer;
}

@end
