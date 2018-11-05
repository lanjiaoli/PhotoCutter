//
//  LAlbumShowViewController.m
//  GTW
//
//  Created by L on 2018/5/14.
//  Copyright © 2018年 imeng. All rights reserved.
//

#import "LAlbumShowViewController.h"
#import <Photos/Photos.h>
#import "AlbumShareSingleton.h"
#import "PhotoTweaksViewController.h"
#import <Masonry.h>

#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define weakTypesFY  __weak typeof(self)weakS = self;

#pragma mark - ****************** GTAlbumShowCollectionCell ***************
@interface LAlbumShowCollectionCell()
@property (nonatomic, strong) UIImageView *imageView;
@end
@implementation LAlbumShowCollectionCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.imageView = [[UIImageView alloc]init];
        [self.contentView addSubview:self.imageView];
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(0);
            make.left.equalTo(self).offset(0);
            make.right.equalTo(self).offset(0);
            make.bottom.equalTo(self).offset(0);
        }];
    }
    return self;
}
- (void)setAsset:(PHAsset *)asset{
    _asset = asset;
    __weak typeof(self) weakS = self;
    [[AlbumShareSingleton shareSingleton]accessToImageAccordingToTheAsset:asset size:CGSizeMake((SCREEN_WIDTH/3-10)*1.7, (SCREEN_WIDTH/3-10)*1.7) resizeMode:(PHImageRequestOptionsResizeModeFast) completion:^(UIImage *image, NSDictionary *info) {
        weakS.imageView.image = image;
    }];
}
@end
#pragma mark - ****************** GTAlbumShowViewController ***************
@interface LAlbumShowViewController ()<PhotoTweaksViewControllerDelegate>
@property (nonatomic, strong) NSMutableArray *allAlbumArray;
@end

@implementation LAlbumShowViewController
-(NSMutableArray *)allAlbumArray{
    if (!_allAlbumArray) {
        _allAlbumArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _allAlbumArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"相册资源";
    [self.collectionView registerNib:[UINib nibWithNibName:@"GTAlbumShowCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"GTAlbumShowCollectionCell"];
    [self.collectionView registerClass:[LAlbumShowCollectionCell class] forCellWithReuseIdentifier:@"cell"];
    self.flowLayout.itemSize = CGSizeMake(SCREEN_WIDTH/3- 5, SCREEN_WIDTH/3- 5);
    self.flowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    self.flowLayout.minimumLineSpacing = 5.0;
    self.flowLayout.minimumInteritemSpacing = 0.0;
    NSArray *array = [[AlbumShareSingleton shareSingleton]GetALLphotosUsingPohotKit];
    [self.allAlbumArray addObjectsFromArray:array];
    [self.collectionView layoutIfNeeded]; 
    [_collectionView setContentOffset:CGPointMake(0, _collectionView.contentSize.height - _collectionView.frame.size.height) animated:false];

}

#pragma mark - collection Delagete
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.allAlbumArray.count;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LAlbumShowCollectionCell * albumCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    [albumCell setAsset:self.allAlbumArray[indexPath.row]];
    albumCell.backgroundColor = [UIColor blackColor];
    return albumCell;
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld",indexPath.row);
   
    weakTypesFY
    PHAsset * asset = self.allAlbumArray[indexPath.row];
   
    PHImageRequestOptions*options = [[PHImageRequestOptions alloc]init];
    
    options.deliveryMode=PHImageRequestOptionsDeliveryModeHighQualityFormat;
    
    [[PHImageManager defaultManager]requestImageForAsset:asset targetSize:[UIScreen mainScreen].bounds.size contentMode:PHImageContentModeAspectFit options:options resultHandler:^(UIImage*result,NSDictionary*info) {
        PhotoTweaksViewController *photoTweaksViewController = [[PhotoTweaksViewController alloc] initWithImage:result];
        photoTweaksViewController.delegate = self;
        photoTweaksViewController.autoSaveToLibray = YES;
        photoTweaksViewController.maxRotationAngle = M_PI_4;
        [weakS.navigationController pushViewController:photoTweaksViewController animated:YES];
        
    }];
    
}

#pragma mark - Delegate
/**
 Called on image cropped.
 */
- (void)photoTweaksController:(PhotoTweaksViewController *)controller didFinishWithCroppedImage:(UIImage *)croppedImage{
    
    [controller.navigationController popToRootViewControllerAnimated:YES];
    [self.navigationController popToRootViewControllerAnimated:false];
    if (self.selectImageBlock) {
        self.selectImageBlock(croppedImage);
    }
}

/**
 Called on cropping image canceled
 */
    

- (void)photoTweaksControllerDidCancel:(PhotoTweaksViewController *)controller{
    [controller.navigationController popViewControllerAnimated:YES];
}


@end
