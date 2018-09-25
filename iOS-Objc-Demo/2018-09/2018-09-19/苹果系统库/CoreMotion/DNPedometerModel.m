//
//  DNPedometerModel.m
//  DNPedometer
//
//  Created by zjs on 2018/9/20.
//  Copyright © 2018年 zjs. All rights reserved.
//

#import "DNPedometerModel.h"
#import "DNPedometerManager.h"

@implementation DNPedometerModel

- (instancetype)initWithTitle:(NSString *)title
                    sportData:(NSString *)sportData
                  currentDate:(NSString *)currentDate {
    self = [super init];
    if (self) {
        _title = title;
        _sportData = sportData;
        _currentDate = currentDate;
    }
    return self;
}

@end
