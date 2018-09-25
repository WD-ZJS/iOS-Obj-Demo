//
//  WDImagePickerTools.m
//  WDPhotoPick
//
//  Created by 吴丹 on 2018/9/11.
//  Copyright © 2018 forever.love. All rights reserved.
//

#import "WDImagePickerTools.h"
#import <Photos/Photos.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface WDImagePickerTools () <PHPhotoLibraryChangeObserver>

@property (nonatomic, strong) NSMutableArray *imageArray;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation WDImagePickerTools

#pragma mark =============== 打开相册获取所以相片 ===============
- (void)oepenImageBorrowwWithScuuessBlock:(void (^)(NSArray * _Nonnull))successBlock failBlock:(void (^)(void))aFailBlock {
    
    if ([PHPhotoLibrary authorizationStatus] == PHAuthorizationStatusAuthorized){//用户之前已经授权
        [self getImagesWithScuuessBlock:successBlock];
    }else if([PHPhotoLibrary authorizationStatus] == PHAuthorizationStatusDenied){//用户之前已经拒绝授权
         aFailBlock();
    }else{//弹窗授权时监听
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            if (status == PHAuthorizationStatusAuthorized){//允许
               [self getImagesWithScuuessBlock:successBlock];
            }else{//拒绝
                aFailBlock();
            }
        }];
    }

    [[PHPhotoLibrary sharedPhotoLibrary] registerChangeObserver:self];
}

// 获取相册
- (void)getImagesWithScuuessBlock:(void (^)(NSArray * _Nonnull))successBlock {
    
    PHImageManager * imageManager = [PHImageManager defaultManager];
    NSArray *assetArray = [self getAllAssetInPhotoAblumWithAscending:true];
    
    PHImageRequestOptions *option = [[PHImageRequestOptions alloc] init];
    option.resizeMode = PHImageRequestOptionsResizeModeFast;
    option.networkAccessAllowed = YES;
    
    [assetArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [imageManager requestImageDataForAsset:obj options:option resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info) {
            [self.imageArray addObject:[UIImage imageWithData:imageData]];
            if (stop) {
                successBlock(self.imageArray);
            }
        }];
    }];
}

#pragma mark =============== 获取相册内所有照片资源 ===============
- (NSArray<PHAsset *> *)getAllAssetInPhotoAblumWithAscending:(BOOL)ascending {
    NSMutableArray<PHAsset *> *assets = [NSMutableArray array];
    PHFetchOptions *option = [[PHFetchOptions alloc] init];
    option.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:ascending]];
    PHFetchResult *result = [PHAsset fetchAssetsWithMediaType:PHAssetMediaTypeImage options:option];
    [result enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        PHAsset *asset = (PHAsset *)obj;
        [assets addObject:asset];
    }];
    
    return assets;
}

#pragma mark =============== PHPhotoLibraryChangeObserver ===============
- (void)photoLibraryDidChange:(nonnull PHChange *)changeInstance {
    NSLog(@"%@",changeInstance);
}

#pragma mark =============== Getter ===============
- (NSMutableArray *)imageArray {
    if (!_imageArray) {
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
}
@end
