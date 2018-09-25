//
//  WDPhotoPreviewViewController.m
//  WDPhotoPick
//
//  Created by 吴丹 on 2018/9/14.
//  Copyright © 2018 forever.love. All rights reserved.
//

#import "WDPhotoPreviewViewController.h"
#import "WDPhotoNavigationBar.h"
#import "WDPhotoBottomView.h"

@interface WDPhotoPreviewViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) WDPhotoNavigationBar *wdNavgationBar;
@property (nonatomic, strong) WDPhotoBottomView *bottomView;

@end

@implementation WDPhotoPreviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setupNavigationBar];
    [self setupSubViewsPropertys];
    [self setupSubViewsConstraints];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    };
}

#pragma mark =============== Set up navigation bar style ===============
- (void)setupNavigationBar {
    [self prefersStatusBarHidden];
    [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

#pragma mark =============== Add controls, set properties ===============
- (void)setupSubViewsPropertys {
    self.view.backgroundColor = UIColor.blackColor;
}

#pragma mark =============== Setting control layout constraints ===============
- (void)setupSubViewsConstraints {
    self.bottomView.translatesAutoresizingMaskIntoConstraints = false;
    NSLayoutConstraint *bottom_bottom = [NSLayoutConstraint constraintWithItem:self.bottomView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    NSLayoutConstraint *bottom_leading = [NSLayoutConstraint constraintWithItem:self.bottomView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1 constant:0];
    NSLayoutConstraint *bottom_trealing = [NSLayoutConstraint constraintWithItem:self.bottomView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1 constant:0];
    NSLayoutConstraint *bottom_height = [NSLayoutConstraint constraintWithItem:self.bottomView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:45];
    [self.view addConstraints:@[bottom_bottom,bottom_leading,bottom_trealing, bottom_height]];
    
    self.scrollView.translatesAutoresizingMaskIntoConstraints = false;
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:self.scrollView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:0];
    NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:self.scrollView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1 constant:0];
    NSLayoutConstraint *trealing = [NSLayoutConstraint constraintWithItem:self.scrollView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1 constant:0];
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:self.scrollView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeTop multiplier:1 constant:0];
    [self.view addConstraints:@[top, leading, trealing, bottom]];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.containerView.subviews.firstObject;
}

#pragma mark =============== Getter ===============
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.pagingEnabled = true;
        _scrollView.delegate = self;
        _scrollView.showsVerticalScrollIndicator = true;
        _scrollView.showsHorizontalScrollIndicator = true;
        [_scrollView setMinimumZoomScale:1];
        [_scrollView setMaximumZoomScale:2];
        _scrollView.bouncesZoom = true;
        [_scrollView setZoomScale:1 animated:true];
        [self.view addSubview:_scrollView];
    }
    return _scrollView;
}

- (UIView *)containerView {
    if (!_containerView) {
        _containerView = [[UIView alloc] init];
        _containerView.backgroundColor = UIColor.blackColor;
        [self.scrollView addSubview:_containerView];
    }
    return _containerView;
}

- (WDPhotoBottomView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[WDPhotoBottomView alloc] init];
        _bottomView.sureButton.backgroundColor = UIColor.clearColor;
        _bottomView.backButton.hidden = false;
        [_bottomView.backButton addTarget:self action:@selector(backViewController) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView.sureButton setTitle:@"" forState:UIControlStateNormal];
        [_bottomView.sureButton setImage:[UIImage imageNamed:@"wd_no_selected"] forState:UIControlStateNormal];
        [_bottomView.sureButton setImage:[UIImage imageNamed:@"wd_selected"] forState:UIControlStateSelected];
        __weak typeof(self) weakself = self;
        _bottomView.sureButtonBlock = ^{
            weakself.bottomView.sureButton.selected = !weakself.model.isSelected;
            weakself.model.isSelected =  !weakself.model.isSelected;
        };
        [self.view addSubview:_bottomView];
    }
    return _bottomView;
}

- (void)backViewController {
    if (self.isSelectedItemBlock) {
        self.isSelectedItemBlock(self.model);
    }
    [self.navigationController popViewControllerAnimated:true];
}

#pragma mark =============== Getter ===============
- (void)setModel:(WDPhotoImageModel *)model {
    _model = model;
    
    UIImageView *imageView = [[UIImageView alloc] init];
    [self.containerView addSubview:imageView];

    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.image = model.image;
    CGFloat ratio = (double)imageView.image.size.height / (double)imageView.image.size.width;
    CGFloat photoWidth = UIScreen.mainScreen.bounds.size.width;
    CGFloat photoHeight = UIScreen.mainScreen.bounds.size.width * ratio;
    
    self.containerView.translatesAutoresizingMaskIntoConstraints = false;
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:self.containerView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.scrollView attribute:NSLayoutAttributeTop multiplier:1 constant:0];
    NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:self.containerView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.scrollView attribute:NSLayoutAttributeLeading multiplier:1 constant:0];
    NSLayoutConstraint *trealing = [NSLayoutConstraint constraintWithItem:self.containerView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.scrollView attribute:NSLayoutAttributeTrailing multiplier:1 constant:0];
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:self.containerView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.scrollView attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:self.containerView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:photoHeight];
    [self.scrollView addConstraints:@[top, leading, trealing, bottom, height]];
    
    if (photoHeight < UIScreen.mainScreen.bounds.size.height) {
        imageView.center = CGPointMake(UIScreen.mainScreen.bounds.size.width / 2, UIScreen.mainScreen.bounds.size.height / 2);
        imageView.bounds = CGRectMake(0, 0, photoWidth, photoHeight);
    } else {
        imageView.frame = CGRectMake(0, 0, photoWidth, photoHeight);
    }
    self.scrollView.contentSize = CGSizeMake(photoWidth, photoHeight);
    self.bottomView.sureButton.selected = model.isSelected;
}

@end
