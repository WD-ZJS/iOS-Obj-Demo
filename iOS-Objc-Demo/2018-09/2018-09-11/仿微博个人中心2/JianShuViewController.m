//
//  JianShuViewController.m
//  iOS-Objc-Demo
//
//  Created by 吴丹 on 2018/9/11.
//  Copyright © 2018 forever.love. All rights reserved.
//

#import "JianShuViewController.h"
#import "WDNestTableView.h"
#import "OneViewTableTableViewController.h"
#import "SecondViewTableViewController.h"
#import "ThirdViewCollectionViewController.h"
#import "WDPageBaseViewController.h"
#import "WMPageController.h"

#define Main_Screen_Height      [[UIScreen mainScreen] bounds].size.height
#define Main_Screen_Width       [[UIScreen mainScreen] bounds].size.width

static CGFloat const headViewHeight = 256;

@interface JianShuViewController ()<UITableViewDelegate,UITableViewDataSource,scrollDelegate,WMPageControllerDelegate>

@property (nonatomic, strong) WDNestTableView *nestTableView;
@property (nonatomic, strong) UIScrollView * parentScrollView;
//头部图片
@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong) UIImageView * avatarImage;
@property (nonatomic, strong) UILabel *countentLabel;

@end

@implementation JianShuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.wdNavigationBar.centerButton setTitle:@"仿微博个人中心2" forState:UIControlStateNormal];
    
    [self.view addSubview:self.nestTableView];
    [self.nestTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.wdNavigationBar.mas_bottom);
        make.leading.trailing.bottom.mas_equalTo(0);
    }];
    
    [self.nestTableView addSubview:self.headImageView];
}

#pragma scrollDelegate
-(void)scrollViewLeaveAtTheTop:(UIScrollView *)scrollView {
    self.parentScrollView = scrollView;
    //离开顶部 主View 可以滑动
    self.parentScrollView.scrollEnabled = NO;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //获取滚动视图y值的偏移量
    CGFloat tabOffsetY = [self.nestTableView rectForSection:0].origin.y;
    CGFloat offsetY = scrollView.contentOffset.y;
    
    if (offsetY >= tabOffsetY) {
        scrollView.contentOffset = CGPointMake(0, tabOffsetY);
        self.parentScrollView.scrollEnabled = YES;
    }
    
    /**
     * 处理头部视图
     */
    CGFloat yOffset  = scrollView.contentOffset.y;
    if (yOffset < -headViewHeight) {
        CGRect f = self.headImageView.frame;
        f.origin.y = yOffset ;
        f.size.height =  -yOffset;
        f.origin.y = yOffset;
        self.headImageView.frame = f;
        CGRect avatarF = CGRectMake(f.size.width/2-40, (f.size.height-headViewHeight)+56, 80, 80);
        _avatarImage.frame = avatarF;
        _countentLabel.frame = CGRectMake((f.size.width-Main_Screen_Width)/2+40, (f.size.height-headViewHeight)+172, Main_Screen_Width-80, 36);
    }
}

#pragma mark --tableDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return Main_Screen_Height-64;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.contentView addSubview:self.setPageViewControllers];
    return cell;
}


#pragma mark -- setter/getter

-(UIView *)setPageViewControllers {
    
    WMPageController *pageController = [self p_defaultController];
    pageController.title = @"Line";
    pageController.menuViewStyle = WMMenuViewStyleLine;
    pageController.titleSizeSelected = 15;
    
    [self addChildViewController:pageController];
    [pageController didMoveToParentViewController:self];
    return pageController.view;
}

- (WMPageController *)p_defaultController {
    OneViewTableTableViewController * oneVc  = [OneViewTableTableViewController new];
    oneVc.delegate = self;
    SecondViewTableViewController * twoVc  = [SecondViewTableViewController new];
    twoVc.delegate = self;
    ThirdViewCollectionViewController * thirdVc  = [ThirdViewCollectionViewController new];
    thirdVc.delegate = self;
    
    NSArray *viewControllers = @[oneVc,twoVc,thirdVc];
    
    NSArray *titles = @[@"first",@"second",@"third"];
    WMPageController *pageVC = [[WMPageController alloc] initWithViewControllerClasses:viewControllers andTheirTitles:titles];
    [pageVC setViewFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height)];
    pageVC.delegate = self;
    pageVC.menuItemWidth = 85;
    pageVC.menuHeight = 44;
    pageVC.postNotification = YES;
    pageVC.bounces = YES;
    return pageVC;
}

- (void)pageController:(WMPageController *)pageController willEnterViewController:(__kindof UIViewController *)viewController withInfo:(NSDictionary *)info {
    NSLog(@"%@",viewController);
}

-(UIImageView *)headImageView {
    if (_headImageView == nil){
        
        _headImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg.jpg"]];
        _headImageView.frame = CGRectMake(0, -headViewHeight ,Main_Screen_Width,headViewHeight);
        _headImageView.userInteractionEnabled = YES;
        
        _avatarImage = [[UIImageView alloc] initWithFrame:CGRectMake(Main_Screen_Width/2-40, 56, 80, 80)];
        [_headImageView addSubview:_avatarImage];
        _avatarImage.userInteractionEnabled = YES;
        _avatarImage.layer.masksToBounds = YES;
        _avatarImage.layer.borderWidth = 1;
        _avatarImage.layer.borderColor =[[UIColor colorWithRed:255/255. green:253/255. blue:253/255. alpha:1.] CGColor];
        _avatarImage.layer.cornerRadius = 40;
        _avatarImage.image = [UIImage imageNamed:@"avatar.jpg"];
        
        _countentLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 150, Main_Screen_Width-80, 30)];
        _countentLabel.font = [UIFont systemFontOfSize:12.];
        _countentLabel.textColor = [UIColor colorWithRed:255/255. green:255/255. blue:255/255. alpha:1.];
        _countentLabel.textAlignment = NSTextAlignmentCenter;
        _countentLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _countentLabel.numberOfLines = 0;
        _countentLabel.text = @"我的名字叫Anna";
        [_headImageView addSubview:_countentLabel];
    }
    return _headImageView;
}


-(WDNestTableView *)nestTableView{
    if (_nestTableView == nil) {
        _nestTableView = [[WDNestTableView alloc]init];
        _nestTableView.delegate = self;
        _nestTableView.dataSource = self;
        _nestTableView.showsVerticalScrollIndicator = NO;
        _nestTableView.contentInset = UIEdgeInsetsMake(headViewHeight,0, 0, 0);
        _nestTableView.backgroundColor = [UIColor clearColor];
    }
    return _nestTableView;
}

@end
