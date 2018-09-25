//
//  WDPhotoPickerViewController.m
//  WDPhotoPick
//
//  Created by 吴丹 on 2018/9/13.
//  Copyright © 2018 forever.love. All rights reserved.
//

#import "WDPhotoPickerViewController.h"
#import <Photos/Photos.h>
#import "WDImagePickerTools.h"
#import "WDPhotoImageCollectionViewCell.h"
#import "WDPhotoImageModel.h"
#import "WDPhotoNavigationBar.h"
#import "WDPhotoBottomView.h"
#import "UIScrollView+Photo_PlaceHolder.h"
#import "WDPhotoPlaceHolderView.h"
#import "WDPhotoHUD.h"
#import "WDPhotoPreviewViewController.h"

@interface UINavigationController (StatusBar)
- (UIStatusBarStyle)preferredStatusBarStyle;
@end

@implementation UINavigationController (StatusBar)
- (UIStatusBarStyle)preferredStatusBarStyle {
    return [[self topViewController] preferredStatusBarStyle];
}
@end

@interface WDPhotoPickerViewController () <UICollectionViewDelegate, UICollectionViewDataSource, WDPhotoImageCollectionViewCellDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) NSMutableArray *imageArray;
@property (nonatomic, strong) NSMutableArray *selectedArray;
@property (nonatomic, strong) WDPhotoNavigationBar *wdNavgationBar;
@property (nonatomic, strong) WDPhotoBottomView *bottomView;
@property (nonatomic, strong) WDPhotoPlaceHolderView *placeHolderView;

@end

@implementation WDPhotoPickerViewController

- (void)dealloc {
    NSLog(@"[%@] 被销毁", [self class]);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = true;
    
    [self setupNavigationBar];
    [self setupSubViewsPropertys];
    [self setupSubViewsConstraints];
    [self dataInitialization];
}

#pragma mark =============== Data initialization ===============
- (void)dataInitialization {
    WDImagePickerTools *tools = [[WDImagePickerTools alloc] init];
    
    [tools oepenImageBorrowwWithScuuessBlock:^(NSArray * _Nonnull imageArray) {
        [[WDPhotoHUD hud] showViewWithindicatorViewWithRemindText:@"加载中..."];
        self.imageArray = [NSMutableArray array];
        for (UIImage *image in imageArray) {
            WDPhotoImageModel *model = [[WDPhotoImageModel alloc] init];
            model.image = image;
            model.isSelected = false;
            [self.imageArray addObject:model];
        }
        self.collectionView.noDataView = self.placeHolderView;
        [self.collectionView reloadData];
        [[WDPhotoHUD hud] dismissView];
    } failBlock:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            self.placeHolderView.remindLabel.text = @"暂无获取相册权限\n请前往设置，进行设置";
        });
    }];
}

#pragma mark =============== Set up navigation bar style ===============
- (void)setupNavigationBar {
    
}

#pragma mark =============== Add controls, set properties ===============
- (void)setupSubViewsPropertys {
    self.view.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:self.wdNavgationBar];
    [self.view addSubview:self.bottomView];
    [self.view addSubview:self.collectionView];
}

#pragma mark =============== Setting control layout constraints ===============
- (void)setupSubViewsConstraints {
    
    self.wdNavgationBar.translatesAutoresizingMaskIntoConstraints = false;
    NSLayoutConstraint *nav_top = [NSLayoutConstraint constraintWithItem:self.wdNavgationBar attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:0];
    NSLayoutConstraint *nav_leading = [NSLayoutConstraint constraintWithItem:self.wdNavgationBar attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1 constant:0];
    NSLayoutConstraint *nav_trealing = [NSLayoutConstraint constraintWithItem:self.wdNavgationBar attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1 constant:0];
    NSLayoutConstraint *nav_height = [NSLayoutConstraint constraintWithItem:self.wdNavgationBar attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:UIApplication.sharedApplication.statusBarFrame.size.height + 44];
    [self.view addConstraints:@[nav_top,nav_leading,nav_trealing, nav_height]];
    
    
    self.bottomView.translatesAutoresizingMaskIntoConstraints = false;
    NSLayoutConstraint *bottom_bottom = [NSLayoutConstraint constraintWithItem:self.bottomView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    NSLayoutConstraint *bottom_leading = [NSLayoutConstraint constraintWithItem:self.bottomView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1 constant:0];
    NSLayoutConstraint *bottom_trealing = [NSLayoutConstraint constraintWithItem:self.bottomView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1 constant:0];
    NSLayoutConstraint *bottom_height = [NSLayoutConstraint constraintWithItem:self.bottomView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:45];
    [self.view addConstraints:@[bottom_bottom,bottom_leading,bottom_trealing, bottom_height]];
    
    self.collectionView.translatesAutoresizingMaskIntoConstraints = false;
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.wdNavgationBar attribute:NSLayoutAttributeBottom multiplier:1 constant:5];
    NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1 constant:0];
    NSLayoutConstraint *trealing = [NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1 constant:0];
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeTop multiplier:1 constant:-5];
    [self.view addConstraints:@[top, leading, trealing, bottom]];
}

#pragma mark =============== UICollectionViewDataSourse ===============
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imageArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WDPhotoImageCollectionViewCell *cell = (WDPhotoImageCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"WDPhotoImageCollectionViewCell" forIndexPath:indexPath];
    cell.delegate = self;
    cell.model = self.imageArray[indexPath.item];
    return cell;
}

#pragma mark =============== UICollectionViewDelegate===============

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    WDPhotoImageCollectionViewCell *cell = (WDPhotoImageCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    WDPhotoPreviewViewController *controller = [[WDPhotoPreviewViewController alloc] init];
    controller.model = self.imageArray[indexPath.item];
    controller.isSelectedItemBlock = ^(WDPhotoImageModel * _Nonnull model) {
        
        cell.model.isSelected = model.isSelected;
        
        if (![self.selectedArray containsObject:model]) {
            if (cell.model.isSelected) {
                [self.selectedArray addObject:model];
            }
        } else {
            if (!cell.model.isSelected) {
                [self.selectedArray removeObject:model];
            }
        }
        
        if (self.selectedArray.count == 0) {
            [self.bottomView.sureButton setTitle:@"确定" forState:UIControlStateNormal];
            self.bottomView.sureButton.backgroundColor = UIColor.lightGrayColor;
            self.bottomView.sureButton.userInteractionEnabled = false;
        } else {
            [self.bottomView.sureButton setTitle:[NSString stringWithFormat:@"确定(%ld)",self.selectedArray.count] forState:UIControlStateNormal];
            self.bottomView.sureButton.backgroundColor = self.sureBackgrondColor;
            self.bottomView.sureButton.userInteractionEnabled = true;
        }
        
        [collectionView reloadItemsAtIndexPaths:@[indexPath]];
    };
    [self.navigationController pushViewController:controller animated:true];
}

#pragma mark =============== WDPhotoImageCollectionViewCellDelegate ===============
- (void)photoSelectedAtCell:(WDPhotoImageCollectionViewCell *)cell {
    cell.model.isSelected = !cell.model.isSelected;
    
    if ([self.selectedArray containsObject:cell.model]) {
        [self.selectedArray removeObject:cell.model];
    } else {
        [self.selectedArray addObject:cell.model];
    }

    if (self.selectedArray.count == 0) {
        [self.bottomView.sureButton setTitle:@"确定" forState:UIControlStateNormal];
        self.bottomView.sureButton.backgroundColor = UIColor.lightGrayColor;
        self.bottomView.sureButton.userInteractionEnabled = false;
    } else {
        [self.bottomView.sureButton setTitle:[NSString stringWithFormat:@"确定(%ld)",self.selectedArray.count] forState:UIControlStateNormal];
        self.bottomView.sureButton.backgroundColor = self.sureBackgrondColor;
        self.bottomView.sureButton.userInteractionEnabled = true;
    }
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
        [_collectionView registerClass:[WDPhotoImageCollectionViewCell class] forCellWithReuseIdentifier:@"WDPhotoImageCollectionViewCell"];
        _collectionView.noDataView = self.placeHolderView;
    }
    return _collectionView;
}

- (WDPhotoPlaceHolderView *)placeHolderView {
    if (!_placeHolderView) {
        _placeHolderView = [[WDPhotoPlaceHolderView alloc] init];
    }
    return _placeHolderView;
}

- (UICollectionViewFlowLayout *)flowLayout {
    if (!_flowLayout) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    }
    return _flowLayout;
}

- (WDPhotoNavigationBar *)wdNavgationBar {
    if (!_wdNavgationBar) {
        _wdNavgationBar = [[WDPhotoNavigationBar alloc] init];
        _wdNavgationBar.backgroundColor = UIColor.whiteColor;
        _wdNavgationBar.centerLabel.text = @"全部照片";
        __weak typeof(self) weakself = self;
        _wdNavgationBar.cancelButtonBlock = ^{
            [weakself dismissViewControllerAnimated:true completion:nil];
        };
    }
    return _wdNavgationBar;
}

- (WDPhotoBottomView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[WDPhotoBottomView alloc] init];
        __weak typeof(self) weakself = self;
        _bottomView.sureButtonBlock = ^{
            NSMutableArray *tempArray = [NSMutableArray array];
            for (WDPhotoImageModel *model in weakself.selectedArray) {
                [tempArray addObject:model.image];
            }
            
            if (weakself.userSelectedImageArray) {
                weakself.userSelectedImageArray(tempArray);
            }
            
            [weakself dismissViewControllerAnimated:true completion:nil];
        };
    }
    return _bottomView;
}

- (NSMutableArray *)selectedArray {
    if (!_selectedArray) {
        _selectedArray = [NSMutableArray array];
    }
    return _selectedArray;
}

#pragma mark =============== Getter ===============

- (void)setNavgationBarBackgrondColor:(UIColor *)navgationBarBackgrondColor {
    self.wdNavgationBar.backgroundColor = navgationBarBackgrondColor;
}

- (void)setTitleTextColor:(UIColor *)titleTextColor {
    self.wdNavgationBar.centerLabel.textColor = titleTextColor;
}

- (void)setCancelTextColor:(UIColor *)cancelTextColor {
    [self.wdNavgationBar.cancelButton setTitleColor:cancelTextColor forState:UIControlStateNormal];
}

- (void)setSureBackgrondColor:(UIColor *)sureBackgrondColor {
    _sureBackgrondColor = sureBackgrondColor;
    if (self.selectedArray.count > 0) {
        self.bottomView.sureButton.backgroundColor = sureBackgrondColor;
        self.bottomView.sureButton.userInteractionEnabled = true;
    } else {
        self.bottomView.sureButton.backgroundColor = UIColor.lightGrayColor;
        self.bottomView.sureButton.userInteractionEnabled = false;
    }
}

- (void)setSureTextColor:(UIColor *)sureTextColor {
    _sureTextColor = sureTextColor;
    if (self.selectedArray.count > 0) {
        [self.bottomView.sureButton setTitleColor:sureTextColor forState:UIControlStateNormal];
    } else {
        [self.bottomView.sureButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    }
}

- (void)setStatusBarStyle:(UIStatusBarStyle)statusBarStyle {
    _statusBarStyle = statusBarStyle;
    [self setNeedsStatusBarAppearanceUpdate];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return  self.statusBarStyle;
}

@end
