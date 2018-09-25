//
//  WDBannerView.m
//  iOS-Objc-Demo
//
//  Created by 吴丹 on 2018/9/17.
//  Copyright © 2018 forever.love. All rights reserved.
//

#import "WDBannerView.h"

@interface WDBannerView () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, copy) NSArray *imageArray;
@property (nonatomic, copy) NSArray *imageArrayNew;

@property (nonatomic, strong) NSMutableArray *netImageArray;
@property (nonatomic, strong) NSMutableArray *netImageArrayNew;
@property (nonatomic, weak) NSTimer *timer;

@end

@implementation WDBannerView

#pragma mark =============== Dealloc ===============
- (void)dealloc {
    [self stopTimer];
}

#pragma mark =============== 加载本地图片 ===============
- (instancetype)initLoadLocalBannerWithImageArray:(NSArray<NSString *> *)imageArray {
    self = [super init];
    if (self) {
        _imageArray = imageArray;
        [self setupConstraints];
    }
    return self;
}

#pragma mark =============== 加载网络图片 ===============
- (instancetype)initLoadInterBannerWithImageArray:(NSArray<NSString *> *)imageArray {
    self = [super init];
    if (self) {
        [self downLoadImageFromNetWithUrlArray:imageArray];
    }
    return self;
}

#pragma mark =============== 通过Url下载图片 ===============
- (void)downLoadImageFromNetWithUrlArray:(NSArray<NSString *> *)urlArray {
    self.netImageArray = [NSMutableArray array];
    dispatch_queue_t globalQueue = dispatch_get_global_queue(0, 0);
    dispatch_async(globalQueue, ^{
        [urlArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSURL *imageURL = [NSURL URLWithString:obj];
            NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
            UIImage *image = [UIImage imageWithData:imageData];
            if (stop) {
                [self.netImageArray addObject:image];
            }
        }];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self setupConstraints];
            self.scrollView.contentSize = CGSizeMake(self.frame.size.width * (self.netImageArray.count + 2), 0);
            [self.scrollView setContentOffset:CGPointMake(self.frame.size.width, 0) animated:NO];
            [self loadBannerWithImageArray:self.netImageArray];
        });
    });
}

#pragma mark =============== layoutSubviews ===============
- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.imageArray.count > 0) {
        self.scrollView.contentSize = CGSizeMake(self.frame.size.width * (self.imageArray.count + 2), 0);
        [self.scrollView setContentOffset:CGPointMake(self.frame.size.width, 0) animated:NO];
        [self loadBannerWithImageArray:self.imageArray];
    }
}

#pragma mark =============== 加载图片 ===============
- (void)loadBannerWithImageArray:(NSArray<NSString *> *)imageArray {
    for (int i = 0; i < imageArray.count + 2; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(self.scrollView.frame.size.width * i, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
        [self.scrollView addSubview:imageView];
    }
    
    self.pageControl.currentPage = 1;
    self.pageControl.numberOfPages = imageArray.count;
    
    [self startTimer];
    
    [self addPics];
}

#pragma mark =============== 开启定时器 ===============
- (void)startTimer {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

#pragma mark =============== 关闭定时 ===============
- (void)stopTimer {
    [self.timer invalidate];
    self.timer = nil;
}

#pragma mark =============== 设置imageView ===============
- (void)addPics {
    for (int i = 0; i < self.imageArrayNew.count; i++) {
        UIImageView *imageView = self.imageArrayNew[i];
        if (i == 0) {
            imageView = [self.imageArrayNew lastObject];
        }else if(i == self.imageArrayNew.count - 1){
            imageView = [self.imageArrayNew firstObject];
        }else{
            imageView = self.imageArrayNew[i - 1];
        }
    }
}

#pragma mark =============== 定时器下一页 ===============
- (void)nextImage {
    NSInteger page = self.pageControl.currentPage;
    page = self.pageControl.currentPage + 1;
    CGPoint offset = CGPointMake((1 + page) * self.scrollView.frame.size.width, 0);
    [self.scrollView setContentOffset:offset animated:YES];
}

#pragma mark =============== 网络图片或者本地图片数组 ===============
- (NSArray *)imageArrayNew{
    if (!_imageArrayNew) {
        NSMutableArray *arr = [NSMutableArray array];
        // 加载网络图片
        if (self.netImageArray.count > 0) {
            for (int i = 0; i < self.netImageArray.count + 2; i++) {
                UIImageView *imageView = [[UIImageView alloc] init];
                CGFloat imageX = i * self.frame.size.width;
                CGFloat imageY = 0;
                
                if (i == self.netImageArray.count + 1) {
                    imageView.image = self.netImageArray.firstObject;
                } else if (i == 0) {
                    imageView.image = self.netImageArray.lastObject;
                } else {
                    imageView.image = self.netImageArray[i-1];
                }
                CGFloat imageW = self.frame.size.width;
                CGFloat imageH = self.frame.size.height;
                imageView.frame = CGRectMake(imageX, imageY, imageW,imageH);
                [self.scrollView insertSubview:imageView atIndex:0];
                [arr addObject:imageView];
            }
        } else {
            // 加载本地图片
            for (int i = 0; i < self.imageArray.count + 2; i++) {
                UIImageView *imageView = [[UIImageView alloc] init];
                CGFloat imageX = i * self.scrollView.frame.size.width;
                CGFloat imageY = 0;
                if (i == self.imageArray.count + 1) {
                    imageView.image = [UIImage imageNamed:self.imageArray[0]];
                } else if (i == 0) {
                    imageView.image = [UIImage imageNamed:self.imageArray.lastObject];
                } else {
                    imageView.image = [UIImage imageNamed:self.imageArray[i-1]];
                }
                CGFloat imageW = self.scrollView.frame.size.width;
                CGFloat imageH = self.scrollView.frame.size.height;
                imageView.frame = CGRectMake(imageX, imageY, imageW,imageH);
                [self.scrollView insertSubview:imageView atIndex:0];
                [arr addObject:imageView];
            }
        }
        _imageArrayNew = arr;
    }
    
    return _imageArrayNew;
}

#pragma mark =============== 设置布局 ===============
- (void)setupConstraints{
    [self scrollViewConstraint];
    [self pageControlConstraint];
}

#pragma mark =============== UIPageControll ===============
- (void)pageControlConstraint {
    [self addSubview:self.pageControl];
    self.pageControl.translatesAutoresizingMaskIntoConstraints = false;
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:self.pageControl attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:self.pageControl attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1 constant:0];
    NSLayoutConstraint *trealing = [NSLayoutConstraint constraintWithItem:self.pageControl attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1 constant:0];
    NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:self.pageControl attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:20];
    [self addConstraints:@[bottom, leading,trealing, height]];
}

#pragma mark =============== UIScrollView ===============
- (void)scrollViewConstraint {
    [self addSubview:self.scrollView];
    self.scrollView.translatesAutoresizingMaskIntoConstraints = false;
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:self.scrollView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:self.scrollView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1 constant:0];
    NSLayoutConstraint *trealing = [NSLayoutConstraint constraintWithItem:self.scrollView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1 constant:0];
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:self.scrollView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:0];
    [self addConstraints:@[top, leading,trealing, bottom]];
}

#pragma mark =============== UIScrollViewDelegate ===============
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger count = self.imageArray.count > 0 ? self.imageArray.count : self.netImageArray.count;
    if (scrollView.contentOffset.x == self.scrollView.frame.size.width * (count + 1)) {
        [self.scrollView setContentOffset:CGPointMake(self.scrollView.frame.size.width, 0) animated:NO];
    }else if(scrollView.contentOffset.x == 0){
        [self.scrollView setContentOffset:CGPointMake(self.scrollView.frame.size.width * count, 0) animated:NO];
    }
    self.pageControl.currentPage = (self.scrollView.contentOffset.x + self.scrollView.frame.size.width * 0.5f) / self.scrollView.frame.size.width  - 1;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self stopTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self startTimer];
}

#pragma mark =============== Getter ===============
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.pagingEnabled = true;
        _scrollView.delegate = self;
        _scrollView.showsVerticalScrollIndicator = false;
        _scrollView.showsHorizontalScrollIndicator = false;
        _scrollView.backgroundColor = UIColor.lightGrayColor;
    }
    return _scrollView;
}

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
    }
    return _pageControl;
}

@end
