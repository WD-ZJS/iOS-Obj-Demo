//
//  DNPedometerManager.m
//  DNPedometer
//
//  Created by zjs on 2018/9/19.
//  Copyright © 2018年 zjs. All rights reserved.
//

#import "DNPedometerManager.h"
#import <CoreMotion/CoreMotion.h>

static DNPedometerManager *_manager = nil;

@interface DNPedometerManager ()

@property (nonatomic, strong) CMPedometer * pedometer;
@end

@implementation DNPedometerManager

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!_manager) {
            _manager = [super allocWithZone:zone];
        }
    });
    return _manager;
}

+ (instancetype)defaultManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!_manager) {
            _manager = [[self alloc] init];
        }
    });
    return _manager;
}

- (id)copyWithZone:(NSZone *)zone {
    return _manager;
}

- (void)dn_startCalculatorStep:(void (^)(NSString * _Nonnull, NSString * _Nonnull))handler {
    
    if ([CMPedometer isStepCountingAvailable] && [CMPedometer isDistanceAvailable]) {
        
        [self.pedometer startPedometerUpdatesFromDate:[self currentDate] withHandler:^(CMPedometerData * _Nullable pedometerData, NSError * _Nullable error) {
            
            NSString * stepStr  = [pedometerData.numberOfSteps stringValue];
            CGFloat    distanceNum = [pedometerData.distance doubleValue] / 1000;
            NSString * distance = [NSString stringWithFormat:@"%.2f KM",distanceNum];
            
            handler(stepStr, distance);
        }];
    }
    else {
        NSLog(@"该设备不支持计步");
    }
}

- (void)dn_stopCalculatorStep {
    
}

- (CMPedometer *)pedometer {
    if (!_pedometer) {
        _pedometer = [[CMPedometer alloc] init];
    }
    return _pedometer;
}

- (NSDate *)currentDate {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *anchorComponents = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:[NSDate date]];
    // 用于锚集合的时间间隔
    NSDate *anchorDate = [calendar dateFromComponents:anchorComponents];
    
    // 采样时间间隔
    NSDateComponents *intervalComponents = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:[NSDate date]];
    intervalComponents.day = anchorComponents.day + 1;
    
    NSDate *endDate = [calendar dateFromComponents:intervalComponents];
    
    NSLog(@"%@===%@",anchorDate,endDate);
    return anchorDate;
}


@end
