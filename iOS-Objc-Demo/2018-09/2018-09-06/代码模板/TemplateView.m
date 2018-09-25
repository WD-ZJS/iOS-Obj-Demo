//
//  TemplateView.m
//  iOS-Demo
//
//  Created by 吴丹 on 2018/9/6.
//  Copyright © 2018 forever.love. All rights reserved.
//

#import "TemplateView.h"

@interface TemplateView ()

@end

@implementation TemplateView

#pragma mark =============== Initial ===============
- (instancetype)init {
    self = [super init];
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

@end
