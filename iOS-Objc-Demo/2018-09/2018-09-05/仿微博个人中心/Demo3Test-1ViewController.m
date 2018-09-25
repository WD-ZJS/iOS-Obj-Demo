//
//  Demo3Test-1ViewController.m
//  iOS-Demo
//
//  Created by 吴丹 on 2018/9/5.
//  Copyright © 2018 forever.love. All rights reserved.
//

#import "Demo3Test-1ViewController.h"
#import "Demo2ViewController.h"


#define random(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0]

#define randomColor random(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

@interface Demo3Test_1ViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation Demo3Test_1ViewController

#pragma mark - LifeCyle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray *viewArray = [NSMutableArray array];
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    [self.view addSubview:scrollView];
    
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.mas_equalTo(0);
        make.top.mas_equalTo(0);
    }];
    
    [scrollView layoutIfNeeded];
    
    for (int i=0; i<100; i++) {
        UIButton *view = [[UIButton alloc] init];
        view.backgroundColor = randomColor;
        [view setTitle:[NSString stringWithFormat:@"%d",i+1] forState:UIControlStateNormal];
        [view setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        [viewArray addObject:view];
    }
    
    [self wd_masLayoutSubViewsWithViewArray:viewArray
                                columnOfRow:3
                      topBottomOfItemSpeace:15
                        leftRightItemSpeace:20
                       topOfSuperViewSpeace:0
                   leftRightSuperViewSpeace:0
                            addToSubperView:scrollView
                                 viewHeight:100];
    // 计算scrollView的contentSize
    scrollView.contentSize = CGSizeMake(0, 100+(15+100) * viewArray.count/3);
    scrollView.delegate = self;
    self.scrollView = scrollView;
    self.wd_scrollView = scrollView;
}


/**
 多视图布局
 
 @param viewArray 视图数组
 @param column 列数
 @param tbSpeace 视图上下间距
 @param lrSpeace 视图左右间距
 @param topSpeace 和父视图上间距
 @param lrSuperViewSpeace 父视图左右间距
 @param superView 父视图
 @param viewHeight 视图高度
 */
- (void)wd_masLayoutSubViewsWithViewArray:(NSArray<UIView *> *)viewArray
                              columnOfRow:(NSInteger)column
                    topBottomOfItemSpeace:(CGFloat)tbSpeace
                      leftRightItemSpeace:(CGFloat)lrSpeace
                     topOfSuperViewSpeace:(CGFloat)topSpeace
                 leftRightSuperViewSpeace:(CGFloat)lrSuperViewSpeace
                          addToSubperView:(UIView *)superView
                               viewHeight:(CGFloat)viewHeight{
    
    CGFloat viewWidth = superView.bounds.size.width;
    CGFloat itemWidth = (viewWidth - lrSuperViewSpeace * 2 - (column - 1) * lrSpeace) / column * 1.0f;
    CGFloat itemHeight = viewHeight;
    UIView *last = nil;
    
    for (int i = 0; i < viewArray.count; i++) {
        UIView *item = viewArray[i];
        [superView addSubview:item];
        
        [item mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(itemWidth);
            make.height.mas_equalTo(itemHeight);
            
            CGFloat top = topSpeace + (i / column) * (itemHeight + tbSpeace);
            make.top.mas_offset(top);
            if (!last || (i % column) == 0) {
                make.left.mas_offset(lrSuperViewSpeace);
            }else{
                make.left.mas_equalTo(last.mas_right).mas_offset(lrSpeace);
            }
        }];
        
        last = item;
    }
}


- (void)wd_scrollViewDidScroll:(UIScrollView *)scrollView {
    [super wd_scrollViewDidScroll:scrollView];
}

- (void)scrollToTop {
    [self.scrollView setContentOffset:CGPointZero animated:false];
}

@end
