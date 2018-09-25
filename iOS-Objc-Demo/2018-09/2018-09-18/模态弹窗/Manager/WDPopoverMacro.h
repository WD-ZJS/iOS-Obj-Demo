//
//  WDPopoverMacro.h
//  iOS-Objc-Demo
//
//  Created by 吴丹 on 2018/9/18.
//  Copyright © 2018 forever.love. All rights reserved.
//

#ifndef WDPopoverMacro_h
#define WDPopoverMacro_h

#define WeakSelf(weakSelf)  __weak __typeof(&*self)weakSelf = self;

typedef void(^WDCompleteHandle)(BOOL presented);

typedef NS_ENUM(NSInteger, WDPopoverType) {
    WDPopoverTypeActionSheet = 0,
    WDPopoverTypeAlert = 1 << 0
};

#endif /* WDPopoverMacro_h */
