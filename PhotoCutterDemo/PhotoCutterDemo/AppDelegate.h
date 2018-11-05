//
//  AppDelegate.h
//  PhotoCutterDemo
//
//  Created by L on 2018/11/5.
//  Copyright © 2018 L. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

