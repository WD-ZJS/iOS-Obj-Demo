//
//  DNContactsCell.m
//  iOS-Objc-Demo
//
//  Created by zjs on 2018/9/12.
//  Copyright © 2018年 forever.love. All rights reserved.
//

#import "DNContactsCell.h"

@interface DNContactsCell ()

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *age;
@property (weak, nonatomic) IBOutlet UILabel *sex;

@end

@implementation DNContactsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(DNContactsModel *)model {
    
    _model = model;
    
    self.name.text = model.name;
    self.age.text  = model.age;
    self.sex.text  = model.sex;
}
@end
