//
//  AppDelegate.h
//  iOS-Objc-Demo
//
//  Created by 吴丹 on 2018/9/7.
//  Copyright © 2018 forever.love. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DNFPSLabel.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) DNFPSLabel *fpsLabel;

@end

