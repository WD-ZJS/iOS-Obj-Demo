//
//  UIScrollView+Photo_PlaceHolder.m
//  iOS-Objc-Demo
//
//  Created by 吴丹 on 2018/9/14.
//  Copyright © 2018 forever.love. All rights reserved.
//

#import "UIScrollView+Photo_PlaceHolder.h"
#import <objc/runtime.h>

static char *placeholderViewKey = "placeholderViewKey";

@implementation UIScrollView (Photo_PlaceHolder)

#pragma mark =============== Setter ===============
- (void)setNoDataView:(UIView *)noDataView {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class class = [self class];
        SEL sel1 = @selector(reloadData);
        SEL sel2 = @selector(wd_reloadData);
        
        Method originalMethod = class_getInstanceMethod(class, sel1);
        Method swizzledMethod = class_getInstanceMethod(class, sel2);
        BOOL success = class_addMethod(class, sel1, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        if (success) {
            class_replaceMethod(class, sel2, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }        
    });
    
    objc_setAssociatedObject(self, placeholderViewKey, noDataView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark =============== Getter ===============
- (UIView *)noDataView {
    UIView *noDataView = objc_getAssociatedObject(self, placeholderViewKey);
    noDataView.frame = self.frame;
    return noDataView;
}

- (void)wd_reloadData {
    [self wd_reloadData];
    [self wd_checkData];
}

#pragma mark =============== 获取数据 ===============
- (void)wd_checkData {
    NSInteger items = 0;
    
    if (![self respondsToSelector:@selector(dataSource)]) {
        return;
    }
    
    // UITableView support
    if ([self isKindOfClass:[UITableView class]]) {
        
        UITableView *tableView = (UITableView *)self;
        id <UITableViewDataSource> dataSource = tableView.dataSource;
        
        NSInteger sections = 1;
        
        if (dataSource && [dataSource respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
            sections = [dataSource numberOfSectionsInTableView:tableView];
        }
        
        if (dataSource && [dataSource respondsToSelector:@selector(tableView:numberOfRowsInSection:)]) {
            for (NSInteger section = 0; section < sections; section++) {
                items += [dataSource tableView:tableView numberOfRowsInSection:section];
            }
        }
    }
    // UICollectionView support
    else if ([self isKindOfClass:[UICollectionView class]]) {
        
        UICollectionView *collectionView = (UICollectionView *)self;
        id <UICollectionViewDataSource> dataSource = collectionView.dataSource;
        
        NSInteger sections = 1;
        
        if (dataSource && [dataSource respondsToSelector:@selector(numberOfSectionsInCollectionView:)]) {
            sections = [dataSource numberOfSectionsInCollectionView:collectionView];
        }
        
        if (dataSource && [dataSource respondsToSelector:@selector(collectionView:numberOfItemsInSection:)]) {
            for (NSInteger section = 0; section < sections; section++) {
                items += [dataSource collectionView:collectionView numberOfItemsInSection:section];
            }
        }
    }
    
    if ( items == 0 ) {
        [self.superview addSubview:self.noDataView];
    } else {
        [self.noDataView removeFromSuperview];
    }
}

@end
