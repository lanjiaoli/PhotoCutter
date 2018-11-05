//
//  AlbumShareSingleton.h
//  PhotoCutterDemo
//
//  Created by L on 2018/11/5.
//  Copyright © 2018 L. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>

NS_ASSUME_NONNULL_BEGIN

@interface AlbumShareSingleton : NSObject
+ (AlbumShareSingleton *)shareSingleton;
/**
 获取相册所有资源
 
 @return PHAsset对象
 */
-(NSMutableArray*)GetALLphotosUsingPohotKit;
/**
 获取相册里的所有图片的PHAsset对象
 
 @param assetCollection 对象
 @param ascending 编码
 @return 获取相册PHAsset对象
 */
- (NSArray *)getAllPhotosAssetInAblumCollection:(PHAssetCollection *)assetCollection ascending:(BOOL)ascending;
/**
 根据PHAsset获取图片信息
 
 @param asset PHAsset对象
 @param size 图片大小
 @param resizeMode PHImageRequestOptionsResizeMode
 @param completion 完成回调
 */
- (void)accessToImageAccordingToTheAsset:(PHAsset *)asset size:(CGSize)size resizeMode:(PHImageRequestOptionsResizeMode)resizeMode completion:(void(^)(UIImage *image,NSDictionary *info))completion;
@end

NS_ASSUME_NONNULL_END
