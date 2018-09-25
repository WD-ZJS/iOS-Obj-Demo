//
//  WDSegmentView.h
//  iOS-Demo
//
//  Created by 吴丹 on 2018/9/5.
//  Copyright © 2018 forever.love. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WDSegmentView : UIView

- (instancetype)initWithTitleArray:(NSArray *)aTitleArray;
@property (nonatomic, copy) void (^buttonClickBlock)(NSInteger index);
@property (nonatomic, assign) NSInteger buttonIndex;

@end
