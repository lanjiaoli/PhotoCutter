//
//  ViewController.m
//  PhotoCutterDemo
//
//  Created by L on 2018/11/5.
//  Copyright © 2018 L. All rights reserved.
//

#import "ViewController.h"
#import "LAlbumShowViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)selectAction:(id)sender {
    LAlbumShowViewController *albumVC = [[LAlbumShowViewController alloc]init];
    __weak typeof(self) weak_Self = self;
    albumVC.selectImageBlock = ^(UIImage *image) {
        [weak_Self.imageView setImage:image];
    };
    [self.navigationController pushViewController:albumVC animated:YES];
}

@end
