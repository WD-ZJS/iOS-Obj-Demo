//
//  DNContactsModel.m
//  iOS-Objc-Demo
//
//  Created by zjs on 2018/9/12.
//  Copyright © 2018年 forever.love. All rights reserved.
//

#import "DNContactsModel.h"

@implementation DNContactsModel

- (instancetype)initWithName:(NSString *)name
                         age:(NSString *)age
                         sex:(NSString *)sex {
    
    self = [super init];
    if (self) {
        self.name = name;
        self.age  = age;
        self.sex  = sex;
    }
    return self;
}
@end
