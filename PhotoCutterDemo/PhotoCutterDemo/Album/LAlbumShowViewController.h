//
//  LAlbumShowViewController.h
//  GTW
//
//  Created by L on 2018/5/14.
//  Copyright © 2018年 imeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

@interface LAlbumShowCollectionCell: UICollectionViewCell
@property (nonatomic, strong) PHAsset *asset;

@end
@interface LAlbumShowViewController : UIViewController<UICollectionViewDelegate, UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;
@property (nonatomic,copy) void(^selectImageBlock)(UIImage *image);

@end
