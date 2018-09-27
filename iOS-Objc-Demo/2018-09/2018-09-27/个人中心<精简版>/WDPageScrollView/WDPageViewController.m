//
//  WDPageViewController.m
//  NestingView
//
//  Created by wudan on 2018/9/26.
//  Copyright © 2018 wudan. All rights reserved.
//

#import "WDPageViewController.h"
#import "WDPageCategory.h"
#import "WDPageSegmentView.h"

#define kScreenWidth            [UIScreen mainScreen].bounds.size.width
#define kScreenHeight           [UIScreen mainScreen].bounds.size.height

#define kTopBarHeight           UIApplication.sharedApplication.statusBarFrame.size.height

/*---------------------------------------- 控制器 -----------------------------------------------*/
@interface WDPageViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIScrollView *backgroundScrollView;
@property (nonatomic, strong) UIViewController *currentVC;
@property (nonatomic, assign) CGFloat headerHeight;
@property (nonatomic, strong) UIScrollView *headerScrollView;
@property (nonatomic, strong) WDPageSegmentView *segmentView;
@property (nonatomic, strong) NSArray *vcArray;

@end

@implementation WDPageViewController

#define StopHeight 150

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = true;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super  viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = false;
}


- (WDPageNavigationBar *)topBarView {
    if (!_topBarView) {
        _topBarView = [[WDPageNavigationBar alloc] init];
        _topBarView.backgroundColor = UIColor.clearColor;
        _topBarView.showBottomLabel = false;
    }
    return _topBarView;
}

- (void)configWihVcArray:(NSArray<UIViewController *> *)vcArray titleArray:(NSArray<NSString *> *)aTitleArray headerImage:(NSString *)aHeaderImage {
    
    [self configBottomScrollView];
    
    self.headerHeight = 264;
    
    self.vcArray = vcArray;
    
    self.backgroundScrollView.contentSize = CGSizeMake(kScreenWidth *vcArray.count, 0);
    
    for (int i=0; i<vcArray.count; i++) {
        UIViewController *vc = vcArray[i];
        vc.view.frame = CGRectMake(kScreenWidth * i, 0, kScreenWidth, kScreenHeight);
        [self addChildViewController:vc];
        [self.backgroundScrollView addSubview:vc.view];
        
        for (UIView *view in vc.view.subviews) {
            if ([view isKindOfClass:[UIScrollView class]] || [view isKindOfClass:[UICollectionView class]] ||  [view isKindOfClass:[UITableView class]]) {
                UIScrollView *scrollView = (UIScrollView *)view;
                vc.rootScrollView = scrollView;
                if ([view isKindOfClass:[UITableView class]]) {
                    UITableView *tableView = (UITableView *)view;
                    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, self.headerHeight - kTopBarHeight)];
                    tableView.tableHeaderView = view;
                } else if ([view isKindOfClass:[UIScrollView class]]) {
                    
                }
                [scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
            }
        }
    }
    
    self.headerView = [self getHeaderViewWithImageName:aHeaderImage titleArray:aTitleArray height:self.headerHeight];
    [self.view addSubview:self.headerView];
    self.headerView.userInteractionEnabled = true;
    [self.headerView addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(headerPan:)]];
    
    
    [self.view addSubview:self.topBarView];
    self.topBarView.frame = CGRectMake(0, 0, kScreenWidth, 44 + kTopBarHeight);
}

#pragma mark =============== Header手势 ===============
- (void)headerPan:(UIPanGestureRecognizer *)pan {
    
    CGPoint translation = [pan translationInView:self.view];
    UIScrollView *scrollView = self.currentVC.rootScrollView;
    CGFloat offsetY = scrollView.contentOffset.y-translation.y;

    if (offsetY > -(StopHeight)){
        [scrollView setContentOffset:CGPointMake(0, offsetY)];
    }

    if (pan.state == UIGestureRecognizerStateEnded && offsetY < 0) {
        [scrollView setContentOffset:CGPointZero animated:YES];
    }

    [pan setTranslation:CGPointZero inView:self.view];
}


#pragma mark =============== 观察者模式 ===============
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    if ([keyPath isEqualToString:@"contentOffset"]) {
        
        CGFloat offset = [change[NSKeyValueChangeNewKey] CGPointValue].y;
        UITableView *tableView = object;
        
        
        self.topBarView.backgroundColor = [UIColor colorWithWhite:1 alpha:offset/(kTopBarHeight + 44)];
        
        // 头部显示一半或全部
        if (offset <= (StopHeight) && offset >= 0) {
            self.headerView.y = -offset;
            self.headerView.height = self.headerHeight;
            for (UIViewController *vc in self.childViewControllers) {
                if (vc.rootScrollView.contentOffset.y != tableView.contentOffset.y) {
                    vc.rootScrollView.contentOffset = tableView.contentOffset;
                }
            }
        }
        // 头部完全滑出屏幕
        else if(offset > (StopHeight)) { // 悬停
            self.headerView.y = - (StopHeight);
            self.headerView.height =  self.headerHeight;
            
            for (UIViewController *vc in self.childViewControllers) {
                if (vc.rootScrollView.contentOffset.y < (StopHeight)) {
                    vc.rootScrollView.contentOffset = CGPointMake(vc.rootScrollView.contentOffset.x, (StopHeight));
                }
            }
        }
        // 被下拉状态
        else if (offset < 0){
            self.headerView.y = 0;
            self.headerView.height = self.headerHeight - offset;
            for (UIViewController *vc in self.childViewControllers) {
                if (vc.rootScrollView.contentOffset.y != tableView.contentOffset.y) {
                    vc.rootScrollView.contentOffset = tableView.contentOffset;
                }
            }
        }
    }
}

#pragma mark =============== UIScrollViewDelegate ===============
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    NSInteger index = (NSInteger)(scrollView.contentOffset.x / UIScreen.mainScreen.bounds.size.width);
    self.currentVC = self.vcArray[index];
    [self.segmentView scrollToIndex:index];
}

#pragma mark =============== 绘制headerView ===============
- (UIView *)getHeaderViewWithImageName:(NSString *)imageName titleArray:(NSArray<NSString *> *)aTitleArray height:(CGFloat)aHeight{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, aHeight)];
    view.backgroundColor = [UIColor grayColor];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:imageName];
    [view addSubview:imageView];
    
    imageView.translatesAutoresizingMaskIntoConstraints = false;
    NSLayoutConstraint *img_top = [NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeTop multiplier:1 constant:0];
    NSLayoutConstraint *img_left = [NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeLeft multiplier:1 constant:0];
    NSLayoutConstraint *img_right = [NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeRight multiplier:1 constant:0];
    NSLayoutConstraint *img_bottom = [NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeBottom multiplier:1 constant:-50];
    [view addConstraints:@[img_top, img_left, img_right, img_bottom]];
    
    WDPageSegmentView *segmentView = [[WDPageSegmentView alloc] init];
    segmentView.titleArray = aTitleArray;
    [view addSubview:segmentView];
    [segmentView setScrollToIndexBlock:^(NSInteger index) {
        [self.backgroundScrollView setContentOffset:CGPointMake(kScreenWidth * index, -kTopBarHeight) animated:true];
        self.currentVC = self.vcArray[index];
    }];
    
    segmentView.translatesAutoresizingMaskIntoConstraints = false;
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:segmentView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:imageView attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    NSLayoutConstraint *traling = [NSLayoutConstraint constraintWithItem:segmentView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeTrailing multiplier:1 constant:0];
    NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:segmentView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeLeading multiplier:1 constant:0];
    NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:segmentView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:45];
    [view addConstraints:@[top, leading, traling, height]];
    
    self.segmentView = segmentView;

    return view;
}


#pragma mark =============== 配置底部ScrollView ===============
- (void)configBottomScrollView {
    self.backgroundScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    self.backgroundScrollView.delegate = self;
    self.backgroundScrollView.pagingEnabled = YES;
    self.backgroundScrollView.bounces = YES;
    self.backgroundScrollView.backgroundColor = UIColor.whiteColor;
    self.backgroundScrollView.showsVerticalScrollIndicator = NO;
    self.backgroundScrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.backgroundScrollView];
}
@end
