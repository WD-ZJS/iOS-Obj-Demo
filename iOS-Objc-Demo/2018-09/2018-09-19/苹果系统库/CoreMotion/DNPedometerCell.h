//
//  DNPedometerCell.h
//  DNPedometer
//
//  Created by zjs on 2018/9/20.
//  Copyright © 2018年 zjs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DNPedometerModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DNPedometerCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *sportType;
@property (weak, nonatomic) IBOutlet UILabel *sportData;
@property (weak, nonatomic) IBOutlet UILabel *date;

@property (nonatomic, strong) DNPedometerModel * model;
@end

NS_ASSUME_NONNULL_END
