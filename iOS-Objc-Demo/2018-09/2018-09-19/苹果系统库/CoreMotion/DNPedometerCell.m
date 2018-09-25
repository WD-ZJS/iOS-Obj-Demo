//
//  DNPedometerCell.m
//  DNPedometer
//
//  Created by zjs on 2018/9/20.
//  Copyright © 2018年 zjs. All rights reserved.
//

#import "DNPedometerCell.h"

@implementation DNPedometerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(DNPedometerModel *)model {
    _model = model;
    
    self.sportType.text = model.title;
    self.sportData.text = model.sportData;
    self.date.text = model.currentDate;
}

@end
