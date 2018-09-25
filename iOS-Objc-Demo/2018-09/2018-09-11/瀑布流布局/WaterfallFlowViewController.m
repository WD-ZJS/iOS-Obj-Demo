//
//  WaterfallFlowViewController.m
//  iOS-Objc-Demo
//
//  Created by 吴丹 on 2018/9/11.
//  Copyright © 2018 forever.love. All rights reserved.
//

#import "WaterfallFlowViewController.h"
#import "WDFlowLayout.h"

@interface WaterfallFlowViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) WDFlowLayout *flowLayout;
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation WaterfallFlowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.wdNavigationBar.centerButton setTitle:@"瀑布流布局" forState:UIControlStateNormal];
}

- (WDFlowLayout *)flowLayout {
    if (!_flowLayout){
        _flowLayout = [[WDFlowLayout alloc] init];
    }
    return _flowLayout;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.flowLayout];
        _collectionView.backgroundColor = UIColor.whiteColor;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    }
    return _collectionView;
}

- (void)setupSubviews {
    [self.view addSubview:self.collectionView];
}

- (void)setupSubviewsConstraints {
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.wdNavigationBar.mas_bottom);
        make.leading.trailing.bottom.mas_equalTo(self.view);
    }];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 100;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    cell.contentView.backgroundColor = UIColor.orangeColor;
    return cell;
}

@end
