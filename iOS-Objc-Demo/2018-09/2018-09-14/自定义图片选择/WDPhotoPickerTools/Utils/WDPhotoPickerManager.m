//
//  WDPhotoPickerManager.m
//  WDPhotoPick
//
//  Created by 吴丹 on 2018/9/13.
//  Copyright © 2018 forever.love. All rights reserved.
//

#import "WDPhotoPickerManager.h"
#import "WDPhotoPickerViewController.h"
#import <Photos/Photos.h>
#import "WDPhotoActionSheet.h"


@interface WDPhotoPickerManager () <UIImagePickerControllerDelegate, UIActionSheetDelegate, UINavigationControllerDelegate>

@property (nonatomic, copy) void(^cameraImageBlock)(NSArray<UIImage *> *imageArray);

@end

@implementation WDPhotoPickerManager

+ (instancetype)manager {
    static dispatch_once_t onceToken;
    static WDPhotoPickerManager *manager;
    dispatch_once(&onceToken, ^{
        manager = [[WDPhotoPickerManager alloc] init];
    });
    return manager;
}

#pragma mark =============== 打开方式一 ===============
- (void)openUserPhotoAlbumInViewController:(UIViewController *)controller
                           photoPageConfig:(WDPhotoConfig *)config
                            imageArryBlock:(void(^)(NSArray<UIImage *> * imageArray))anImageArrayBlock {
    [[WDPhotoActionSheet shareInstances] setUIWithTitleArray:@[@"打开相机", @"打开相册"] cancelButtonTitle:@"取消" selectedIndexBlock:^(NSInteger index) {
        if (index == 1) {
            WDPhotoPickerViewController *vc = [[WDPhotoPickerViewController alloc] init];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
            vc.userSelectedImageArray = ^(NSArray<UIImage *> * _Nonnull imageArray) {
                anImageArrayBlock(imageArray);
            };
            vc.navgationBarBackgrondColor = config.navgationBarBackgrondColor;
            vc.titleTextColor =  config.titleTextColor;
            vc.cancelTextColor = config.cancelTextColor;
            vc.sureBackgrondColor = config.sureBackgrondColor;
            vc.sureTextColor = config.sureTextColor;
            vc.statusBarStyle = config.statusBarStyle;
            [controller presentViewController:nav animated:true completion:nil];
        } else {
            [self openCameraWithController:controller imageArryBlock:(void(^)(NSArray<UIImage *> * imageArray))anImageArrayBlock];
        }
    }];
}

#pragma mark =============== 打开方式二 ===============
- (void)openUserPhotoAlbumInViewController:(UIViewController *)controller
                navgationBarBackgrondColor:(UIColor *)aNavgationBarBackgrondColor
                            titleTextColor:(UIColor *)aTitleTextColor
                           cancelTextColor:(UIColor *)aCancelTextColor
                        sureBackgrondColor:(UIColor *)aSureBackgrondColor
                             sureTextColor:(UIColor *)aSureTextColor
                            statusBarStyle:(UIStatusBarStyle)aStatusBarStyle
                            imageArryBlock:(void(^)(NSArray<UIImage *> * imageArray))anImageArrayBlock {
    
    [[WDPhotoActionSheet shareInstances] setUIWithTitleArray:@[@"打开相机", @"打开相册"] cancelButtonTitle:@"取消" selectedIndexBlock:^(NSInteger index) {
        if (index == 1) {
            WDPhotoPickerViewController *vc = [[WDPhotoPickerViewController alloc] init];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
            vc.userSelectedImageArray = ^(NSArray<UIImage *> * _Nonnull imageArray) {
                anImageArrayBlock(imageArray);
            };
            vc.navgationBarBackgrondColor = aNavgationBarBackgrondColor;
            vc.titleTextColor =  aTitleTextColor;
            vc.cancelTextColor = aCancelTextColor;
            vc.sureBackgrondColor = aSureBackgrondColor;
            vc.sureTextColor = aSureTextColor;
            vc.statusBarStyle = aStatusBarStyle;
            [controller presentViewController:nav animated:true completion:nil];
        } else {
            [self openCameraWithController:controller imageArryBlock:(void(^)(NSArray<UIImage *> * imageArray))anImageArrayBlock];
        }
    }];
}

- (void)openCameraWithController:(UIViewController *)controller imageArryBlock:(void(^)(NSArray<UIImage *> * imageArray))anImageArrayBlock{
    // 判断是否支持相机
    
    AVAuthorizationStatus authStatus =  [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = YES;
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    if (authStatus== PHAuthorizationStatusAuthorized){
        //用户之前已经授权
        [controller presentViewController:imagePickerController animated:YES completion:nil];
    } else if (authStatus == PHAuthorizationStatusDenied){
        //用户之前已经拒绝授权
        [self alterConterollerInController:controller];
        return;
    } else {
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            if (granted) {
                [controller presentViewController:imagePickerController animated:YES completion:nil];
            } else {
                [controller dismissViewControllerAnimated:true completion:nil];
            }
        }];
    }
    self.cameraImageBlock = anImageArrayBlock;
}

- (void)alterConterollerInController:(UIViewController *)controller {
    UIAlertController *alter = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"本应用无访问相机的权限，如需访问，可在设置中修改" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self userPushToSetting];
    }];
    
    UIAlertAction *backAction = [UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [controller dismissViewControllerAnimated:true completion:nil];
    }];
    
    [alter addAction:sureAction];
    [alter addAction:backAction];

    [controller presentViewController:alter animated:true completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    self.cameraImageBlock(@[image]);
}

#pragma mark =============== 引导用户打开设置 ===============
- (void)userPushToSetting {
    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
    }
}
@end
