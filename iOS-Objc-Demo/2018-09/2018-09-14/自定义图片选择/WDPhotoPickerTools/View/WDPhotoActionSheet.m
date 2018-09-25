//
//  WDPhotoActionSheet.m
//  WDPhotoPick
//
//  Created by 吴丹 on 2018/9/13.
//  Copyright © 2018 forever.love. All rights reserved.
//

#import "WDPhotoActionSheet.h"

#define Sheet_IS_iPhoneX ([UIScreen mainScreen].bounds.size.width == 375 && [UIScreen mainScreen].bounds.size.height == 812)
#define Sheet_IPHONEX_MARGIN_BOTTOM (34)
#define Sheet_ScreenWidth UIScreen.mainScreen.bounds.size.width
#define Sheet_ScreenHeight UIScreen.mainScreen.bounds.size.height

typedef void (^clickHandler)(NSInteger index);

@interface WDPhotoActionSheet () <UIGestureRecognizerDelegate>
// 背景页面
@property (nonatomic, strong)  UIView *containerView;
@property (nonatomic, copy) void (^clickHandler)(NSInteger index);

@end

@implementation WDPhotoActionSheet

#pragma mark -- 单例初始化
+ (instancetype)shareInstances{
    
    static WDPhotoActionSheet *single;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        single = [[WDPhotoActionSheet alloc] init];
    });
    
    return single;
}

- (void)setUIWithTitleArray:(NSArray<NSString *> *)titleArray
          cancelButtonTitle:(NSString *)cancelButtonTitle
         selectedIndexBlock:(void(^)(NSInteger index))aSelectedIndexBlock {
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(dismissView)];
    tap.delegate = self;
    [self addGestureRecognizer:tap];
    
    @try {
        if(titleArray.count == 0) {
            @throw [NSException exceptionWithName:NSStringFromClass([self class])
                                           reason:@"标题数组不能为空"
                                         userInfo:nil];
        } else {
            [self createUIWithTitleArray:titleArray cancelButtonTitle:cancelButtonTitle selectedIndexBlock:aSelectedIndexBlock];
        }

    } @catch (NSException *exception) {
        @throw exception;
    } @finally {

    }
}



#pragma mark -- 进行页面绘制
- (void)createUIWithTitleArray:(NSArray<NSString *> *)titleArray
             cancelButtonTitle:(NSString *)cancelButtonTitle
            selectedIndexBlock:(void(^)(NSInteger index))aSelectedIndexBlock{
    
    self.containerView = [[UIView alloc] init];
    CGFloat W          = Sheet_ScreenWidth;
    CGFloat X          = 0;
    CGFloat H          = 55;
    CGFloat Speace     = 15;
    
    if(cancelButtonTitle.length > 0) {
        for (int i = 0; i < titleArray.count; i++) {
            UIButton *button = [self createButtonWithTitle:titleArray[i] buttonTag:10 + i];
            button.frame = CGRectMake(X, H * i, W,  H);
            if( i > 0 ) {
                UIView *line = [self createLine];
                line.frame   = CGRectMake(X,  H * i + 0.5, W,  0.5);
            }
        }
        UIButton *cancalButton = [self createButtonWithTitle:cancelButtonTitle buttonTag:9];
        if(Sheet_IS_iPhoneX) {
            cancalButton.frame = CGRectMake(X, (H + 0.5) * titleArray.count + Speace , W, H + Sheet_IPHONEX_MARGIN_BOTTOM);
        } else {
            cancalButton.frame = CGRectMake(X, (H + 0.5) * titleArray.count + Speace , W, H);
        }
        
    }else{
        for (int i = 0; i < titleArray.count; i++) {
            UIButton *button = [self createButtonWithTitle:titleArray[i] buttonTag:10 + i];
            if(i == titleArray.count-1) {
                if(Sheet_IS_iPhoneX){
                    button.frame = CGRectMake(X, H * i , W, H + Sheet_IPHONEX_MARGIN_BOTTOM);
                } else {
                    button.frame = CGRectMake(X, H * i , W, H);
                }
            } else {
                button.frame = CGRectMake(X, H * i, W,  H);
            }
            if( i > 0 ) {
                UIView *line = [self createLine];
                line.frame   = CGRectMake(X,  H * i + 0.5, W,  0.5);
            }
        }
    }
    
    self.clickHandler = aSelectedIndexBlock;
    CGFloat AllHeight = cancelButtonTitle.length > 0  ? (H * (titleArray.count + 1) + 15) : (H * titleArray.count);
    if(Sheet_IS_iPhoneX) {
        AllHeight += Sheet_IPHONEX_MARGIN_BOTTOM;
    }
    [self showViewWithHeight:AllHeight];
}

#pragma mark -- 按钮点击事件进行传值
- (void)buttonAction:(UIButton *)sender {
    if(sender.tag != 9) {
        self.clickHandler(sender.tag - 10);
    }
    [self dismissView];
}

#pragma mark -- 公共创建按钮
- (UIButton *)createButtonWithTitle:(NSString *)title buttonTag:(NSInteger)buttonTag {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button sizeToFit];
    [button setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    button.backgroundColor = UIColor.whiteColor;
    button.tag = buttonTag;
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.containerView addSubview:button];
    return button;
}

#pragma mark -- 公共创建View
- (UIView *)createLine {
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = UIColor.lightGrayColor;
    [self.containerView addSubview:line];
    return line;
}

#pragma mark -- 页面显示
- (void)showViewWithHeight:(CGFloat)height {
    [UIApplication.sharedApplication.keyWindow addSubview:self];
    [self addSubview:self.containerView];
    
    self.frame = UIScreen.mainScreen.bounds;
    self.containerView.frame = CGRectMake(0, Sheet_ScreenHeight, Sheet_ScreenWidth, 0);
    
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
        self.containerView.frame = CGRectMake(0, Sheet_ScreenHeight-height, Sheet_ScreenWidth, height);
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark -- 页面消失
- (void)dismissView {
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
        self.containerView.frame = CGRectMake(0, Sheet_ScreenHeight, Sheet_ScreenWidth, 0);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        [self.containerView removeFromSuperview];
    }];
}


@end
