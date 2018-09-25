//
//  WDNestTableView.m
//  iOS-Objc-Demo
//
//  Created by 吴丹 on 2018/9/12.
//  Copyright © 2018 forever.love. All rights reserved.
//

#import "WDNestTableView.h"

@implementation WDNestTableView

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}
@end
