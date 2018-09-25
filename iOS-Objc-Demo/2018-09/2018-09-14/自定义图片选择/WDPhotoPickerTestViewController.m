//
//  WDPhotoPickerViewController.m
//  iOS-Objc-Demo
//
//  Created by 吴丹 on 2018/9/14.
//  Copyright © 2018 forever.love. All rights reserved.
//

#import "WDPhotoPickerTestViewController.h"
#import "WDPhotoPickerTools/WDPhotoPickerToolHeader.h"
#import "UIScrollView+WD_NoData.h"
#import "WDTestEmptyView.h"

@interface WDPhotoPickerTestViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) NSMutableArray *imageArray;

@end

@implementation WDPhotoPickerTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)setupNavigationBar {
    
    [self.wdNavigationBar.centerButton setTitle:@"图片选择器" forState:UIControlStateNormal];
    [self.wdNavigationBar.rightButton  setTitle:@"添加" forState:UIControlStateNormal];
    
    self.imageArray = [NSMutableArray array];
    
    kWeakSelf(self)
    self.wdNavigationBar.rightButtonBlock = ^{
        WDPhotoConfig *config = [[WDPhotoConfig alloc] init];
        config.navgationBarBackgrondColor = UIColor.orangeColor;
        config.titleTextColor = UIColor.whiteColor;
        config.cancelTextColor = UIColor.whiteColor;
        config.sureBackgrondColor = UIColor.orangeColor;
        config.sureTextColor = UIColor.whiteColor;
        config.statusBarStyle = UIStatusBarStyleLightContent;
        [[WDPhotoPickerManager manager] openUserPhotoAlbumInViewController:weakself photoPageConfig:config imageArryBlock:^(NSArray<UIImage *> * _Nonnull imageArray) {
            [weakself.imageArray addObjectsFromArray:imageArray];
            [weakself.collectionView reloadData];
        }];
    };
}

- (void)setupSubviews {
    WDTestEmptyView *view = [NSBundle.mainBundle loadNibNamed:@"WDTestEmptyView" owner:self options:nil].firstObject;
    self.collectionView.noDataView = view;
    [self.view addSubview:self.collectionView];
}

- (void)setupSubviewsConstraints {
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.wdNavigationBar.mas_bottom);
        make.leading.trailing.bottom.mas_equalTo(self.view);
    }];
}

#pragma mark =============== UICollectionViewDataSourse ===============
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imageArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = (UICollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    cell.backgroundView = [[UIImageView alloc] initWithImage:self.imageArray[indexPath.item]];
    return cell;
}

#pragma mark <UICollectionViewDelegateFlowLayout>
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat item_WH = (UIScreen.mainScreen.bounds.size.width-20.f-2.f*3)/4.f;
    return CGSizeMake(item_WH, item_WH);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 5.f, 10.f, 5.f);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 2.f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 2.f;
}

#pragma mark =============== Getter ===============
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.flowLayout];
        _collectionView.backgroundColor = UIColor.whiteColor;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    }
    return _collectionView;
}

- (UICollectionViewFlowLayout *)flowLayout {
    if (!_flowLayout) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    }
    return _flowLayout;
}

@end
