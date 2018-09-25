//
//  WDWebSoketManager.h
//  iOS-Objc-Demo
//
//  Created by wudan on 2018/9/25.
//  Copyright © 2018 forever.love. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol WDWebSoketManagerDelegate <NSObject>

- (void)getMassageFromSeverWithInfo:(NSString *)info;

@end

@interface WDWebSoketManager : NSObject

@property (nonatomic, weak) id <WDWebSoketManagerDelegate> delegate;

+ (instancetype)manager;

- (void)contactToSeverWithUrlAddress:(NSString *)urlAddress;

- (void)closeContat;

- (void)senderMessager:(NSString *)messager;

@end

NS_ASSUME_NONNULL_END
