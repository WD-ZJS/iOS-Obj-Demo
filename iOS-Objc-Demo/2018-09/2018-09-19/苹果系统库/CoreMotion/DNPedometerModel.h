//
//  DNPedometerModel.h
//  DNPedometer
//
//  Created by zjs on 2018/9/20.
//  Copyright © 2018年 zjs. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DNPedometerModel : NSObject

@property (nonatomic, copy) NSString * title;
@property (nonatomic, copy) NSString * sportData;
@property (nonatomic, copy) NSString * currentDate;


- (instancetype)initWithTitle:(NSString *)title
                    sportData:(NSString *)sportData
                  currentDate:(NSString *)currentDate;

@end

NS_ASSUME_NONNULL_END
