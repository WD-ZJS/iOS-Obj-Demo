//
//  DNContactsModel.h
//  iOS-Objc-Demo
//
//  Created by zjs on 2018/9/12.
//  Copyright © 2018年 forever.love. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DNContactsModel : NSObject

@property (nonatomic, copy) NSString * name;
@property (nonatomic, copy) NSString * age;
@property (nonatomic, copy) NSString * sex;

- (instancetype)initWithName:(NSString *)name
                         age:(NSString *)age
                         sex:(NSString *)sex;
@end
