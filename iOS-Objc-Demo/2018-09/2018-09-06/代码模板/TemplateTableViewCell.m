//
//  TemplateTableViewCell.m
//  iOS-Demo
//
//  Created by 吴丹 on 2018/9/6.
//  Copyright © 2018 forever.love. All rights reserved.
//

#import "TemplateTableViewCell.h"

@implementation TemplateTableViewCell

#pragma mark =============== Initial ===============
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupSubViewsPropertys];
        [self setupSubViewsConstraints];
    }
    return self;
}

#pragma mark =============== Add controls, set properties ===============
- (void)setupSubViewsPropertys { }

#pragma mark =============== Setting control layout constraints ===============
- (void)setupSubViewsConstraints { }

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
