//
//  Demo3ViewController.m
//  iOS-Demo
//
//  Created by 吴丹 on 2018/9/5.
//  Copyright © 2018 forever.love. All rights reserved.
//

#import "Demo3ViewController.h"
#import "WDSegmentView.h"
#import "Demo3Test-1ViewController.h"
#import "Demo3Test-2ViewController.h"

@interface Demo3ViewController ()<UIPageViewControllerDelegate,UIPageViewControllerDataSource, UIGestureRecognizerDelegate>

@property (nonatomic, strong) WDSegmentView *segmentView;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageViewController *pageController;
@property (nonatomic, strong) NSMutableArray<UIViewController *> *vcArray;
@property (nonatomic, assign) BOOL isScrollViewCanScroll;

@end

@implementation Demo3ViewController

#pragma mark - LifeCyle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    if (@available(iOS 11.0, *)) {
        self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationSEL:) name:WDPageViewNotification object:nil];
    
    self.isScrollViewCanScroll = true;
}

- (void)notificationSEL:(id)sender {
    self.isScrollViewCanScroll = true;
    for (PageBaseController *vc in self.vcArray) {
        vc.isCanContentScroll = false;
    }
}

#pragma mark - DidReceiveMemoryWarning
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)dealloc {
    NSLog(@"%@-释放了",self.class);
}

#pragma mark - SetupNavigationBar
- (void)setupNavigationBar{
    [super setupNavigationBar];
    self.wdNavigationBar.showBottomLabel = false;
    self.wdNavigationBar.leftButton.tintColor = UIColor.whiteColor;
    self.wdNavigationBar.backgroundColor = UIColor.clearColor;
}

#pragma mark - SetupSubviewsUI
- (void)setupSubviews{
    
    self.vcArray = [NSMutableArray array];
    
    [self.vcArray addObject:[[Demo3Test_1ViewController alloc] init]];
    [self.vcArray addObject:[[Demo3Test_2ViewController alloc] init]];
    [self.vcArray addObject:[[Demo3Test_1ViewController alloc] init]];

    
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.showsVerticalScrollIndicator = false;
    self.scrollView.showsHorizontalScrollIndicator = false;
    self.scrollView.delegate = self;
    self.scrollView.backgroundColor = UIColor.clearColor;
    [self.view addSubview:self.scrollView];
    [self.view bringSubviewToFront:self.wdNavigationBar];
    
    self.headerView = [[UIView alloc] init];
    self.headerView.backgroundColor = UIColor.redColor;
    [self.scrollView addSubview:self.headerView];
    
    self.segmentView = [[WDSegmentView alloc] initWithTitleArray:@[@"你",@"我",@"她"]];
    [self.scrollView addSubview:self.segmentView];
    kWeakSelf(self)
    self.segmentView.buttonClickBlock = ^(NSInteger index) {
        [weakself showChildViewControllerWithIndex:index];
    };
    
    self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                                                          navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                                        options:@{UIPageViewControllerOptionInterPageSpacingKey:@10}];
    self.pageController.delegate = self;
    self.pageController.dataSource = self;
    [self addChildViewController:self.pageController];
    [self.scrollView addSubview:self.pageController.view];
    
    [self showChildViewControllerWithIndex:0];
}


#pragma mark - SetupSubviewsConstraints
- (void)setupSubviewsConstraints{
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(Screen_Height);
        make.width.mas_equalTo(Screen_Width);
    }];
    
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.mas_equalTo(self.scrollView);
        make.width.mas_equalTo(Screen_Width);
        make.height.mas_equalTo(200);
    }];
    
    [self.segmentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(45);
        make.width.mas_equalTo(Screen_Width);
        make.top.mas_equalTo(self.headerView.mas_bottom);
    }];
    
    [self.pageController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(Screen_Width);
        make.bottom.mas_equalTo(self.scrollView.mas_bottom);
        make.top.mas_equalTo(self.segmentView.mas_bottom);
        make.height.mas_equalTo(UIScreen.mainScreen.bounds.size.height-45);
    }];
    [self.pageController didMoveToParentViewController:self];
}

#pragma mark =============== UIPageViewControllerDataSource ===============
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    if (self.vcArray.count == 0) {
        return nil;
    } else {
        UIViewController *vc = viewController;
        NSInteger i =  [self.vcArray indexOfObject:vc];
        if (i < self.vcArray.count-1) {
            return (UIViewController *)self.vcArray[i+1];
        }
        return nil;
    }
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    if (self.vcArray.count == 0) {
        return nil;
    } else {
        UIViewController *vc = viewController;
        NSInteger i =  [self.vcArray indexOfObject:vc];
        if (i > 0 && i < self.vcArray.count) {
            return (UIViewController *)self.vcArray[i-1];
        }
        return nil;
    }
}

- (void)showChildViewControllerWithIndex:(NSInteger)index {
    
    if (index >= self.vcArray.count || index < 0) {
        return;
    }
    
    NSInteger currentIndex = 0;
    UIViewController *vc = self.pageController.viewControllers.lastObject;
    NSInteger vcIndex = [self.vcArray indexOfObject:vc];
    currentIndex = vcIndex;
    
    UIViewController *toVC = self.vcArray[index];
    
    UIPageViewControllerNavigationDirection dir = currentIndex > index ? UIPageViewControllerNavigationDirectionReverse : UIPageViewControllerNavigationDirectionForward;
    [self.pageController setViewControllers:@[toVC] direction:dir animated:true completion:nil];
}

#pragma mark =============== UIPageViewControllerDelegate ===============
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    UIViewController *lastVC = pageViewController.viewControllers.lastObject;
    self.segmentView.buttonIndex = [self.vcArray indexOfObject:lastVC];
}

#pragma mark =============== UIGestureRecognizerDelegate ===============
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return true;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat Y = scrollView.contentOffset.y;
    if (Y > 0) {
        self.wdNavigationBar.backgroundColor = [UIColor colorWithWhite:1 alpha:Y/44];
        self.wdNavigationBar.centerButton.tintColor = [UIColor colorWithWhite:0 alpha:Y/44];
        self.wdNavigationBar.leftButton.tintColor = [UIColor colorWithWhite:0 alpha:Y/44];
        [self.wdNavigationBar.centerButton setTitle:@"个人中心" forState:UIControlStateNormal];
    } else {
        self.wdNavigationBar.centerButton.tintColor = UIColor.clearColor;
        [self.wdNavigationBar.centerButton setTitle:@"" forState:UIControlStateNormal];
        self.wdNavigationBar.leftButton.tintColor = UIColor.whiteColor;
    }
    
    CGFloat offsetThreshold =  200 - kTopHeight;

    if (Y >  offsetThreshold) {
        [scrollView setContentOffset:CGPointMake(0, offsetThreshold) animated:false];
        self.isScrollViewCanScroll = false;
        for (PageBaseController *vc in self.vcArray) {
            vc.isCanContentScroll = true;
        }
    } else {
        if (!self.isScrollViewCanScroll) {
            [scrollView setContentOffset:CGPointMake(0, offsetThreshold) animated:false];
        }
    }
}

- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView {
    for (PageBaseController *vc in self.vcArray) {
        [vc scrollToTop];
    }
    
    return true;
}

@end
