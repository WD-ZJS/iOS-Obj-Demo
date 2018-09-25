//
//  DropViewTest-02ViewController.m
//  iOS-Demo
//
//  Created by 吴丹 on 2018/9/7.
//  Copyright © 2018 forever.love. All rights reserved.
//

#import "DropViewTest-2ViewController.h"

@interface WDDropCollectionModel : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) BOOL isSelected;

@end

@implementation WDDropCollectionModel


@end

@interface WDDropCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) WDDropCollectionModel *model;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation WDDropCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.contentView.layer.cornerRadius = 10;
        self.contentView.layer.borderColor = UIColor.orangeColor.CGColor;
        self.contentView.layer.borderWidth = 0.5;
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        self.titleLabel.textColor = UIColor.orangeColor;
        [self.contentView addSubview:self.titleLabel];
        
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false;
        NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1 constant:5];
        NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeading multiplier:1 constant:10];
        NSLayoutConstraint *trealing = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTrailing multiplier:1 constant:-10];
        NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1 constant:-5];
        [self.contentView addConstraints:@[top,leading,trealing,bottom]];
    }
    return self;
}

- (void)setModel:(WDDropCollectionModel *)model {
    _model = model;
    self.titleLabel.text = model.title;
    
    if (model.isSelected) {
        self.contentView.backgroundColor = UIColor.orangeColor;
        self.titleLabel.textColor = UIColor.whiteColor;
    } else {
        self.contentView.backgroundColor = UIColor.clearColor;
        self.contentView.layer.cornerRadius = 10;
        self.contentView.layer.borderColor = UIColor.orangeColor.CGColor;
        self.contentView.layer.borderWidth = 0.5;
        self.titleLabel.textColor = UIColor.orangeColor;
    }
}


@end

@interface DropViewTest_2ViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) NSMutableArray<WDDropCollectionModel *> *dataArray;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLatout;
@property (nonatomic, strong) NSMutableArray *selectedArray;

@end

@implementation DropViewTest_2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)setupNavigationBar {
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSArray *array = @[@{@"name":@"苹果",@"isSelected":@"0"} ,
                       @{@"name":@"联想",@"isSelected":@"0"} ,
                       @{@"name":@"华为",@"isSelected":@"0"} ,
                       @{@"name":@"小米",@"isSelected":@"0"} ,
                       @{@"name":@"戴尔",@"isSelected":@"0"} ,
                       @{@"name":@"宏碁",@"isSelected":@"0"} ,
                       @{@"name":@"华硕",@"isSelected":@"0"} ,
                       @{@"name":@"三星",@"isSelected":@"0"} ,
                       @{@"name":@"神州",@"isSelected":@"0"} ,
                       @{@"name":@"外星人",@"isSelected":@"0"}];
    self.dataArray = [NSMutableArray array];
    
    for (NSDictionary *dic in array) {
        WDDropCollectionModel *model = [[WDDropCollectionModel alloc] init];
        model.title = dic[@"name"];
        model.isSelected =  [dic[@"isSelected"] boolValue];
        [self.dataArray addObject:model];
    }
    
    self.selectedArray = [NSMutableArray array];
    [self.collectionView reloadData];
}

#pragma mark - SetupSubviewsUI
- (void)setupSubviews{
    [self.view addSubview:self.collectionView];
}

#pragma mark - SetupSubviewsConstraints
- (void)setupSubviewsConstraints{
    self.collectionView.translatesAutoresizingMaskIntoConstraints = false;
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:10];
    NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1 constant:0];
    NSLayoutConstraint *trealing = [NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1 constant:0];
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    [self.view addConstraints:@[top,leading,trealing,bottom]];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WDDropCollectionViewCell *cell = (WDDropCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"WDDropCollectionViewCell" forIndexPath:indexPath];

    cell.model = self.dataArray[indexPath.item];
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"UICollectionReusableView" forIndexPath:indexPath];
    
    UIButton *button = [[UIButton alloc] init];
    button.layer.cornerRadius = 3;
    button.layer.borderColor = UIColor.blueColor.CGColor;
    button.layer.borderWidth = 0.5;
    [button setTitle:@"确定" forState:UIControlStateNormal];
    [button setTitleColor:UIColor.blueColor forState:UIControlStateNormal];
    [view addSubview:button];
    
    button.translatesAutoresizingMaskIntoConstraints = false;
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeTop multiplier:1 constant:5];
    NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1 constant:50];
    NSLayoutConstraint *trealing = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeTrailing multiplier:1 constant:-10];
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeBottom multiplier:1 constant:-5];
    [view addConstraints:@[top,width,trealing,bottom]];
    return view;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self.selectedArray addObject:@(indexPath.item)];
    [collectionView reloadData];
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.flowLatout];
        _collectionView.backgroundColor = UIColor.whiteColor;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.allowsMultipleSelection = true;
        [_collectionView registerClass:[WDDropCollectionViewCell class] forCellWithReuseIdentifier:@"WDDropCollectionViewCell"];
        [_collectionView registerClass:[UICollectionReusableView class]
            forSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                   withReuseIdentifier:@"UICollectionReusableView"];
    }
    return _collectionView;
}

- (UICollectionViewFlowLayout *)flowLatout {
    if (!_flowLatout) {
        _flowLatout = [[UICollectionViewFlowLayout alloc] init];
        _flowLatout.estimatedItemSize = CGSizeMake(80, 30);
        _flowLatout.minimumInteritemSpacing = 10;
        _flowLatout.footerReferenceSize = CGSizeMake(UIScreen.mainScreen.bounds.size.width, 40);
    }
    return _flowLatout;
}

@end
