//
//  SCNavigationController.h
//  SCCaptureCameraDemo
//
//  Created by Aevitx on 14-1-17.
//  Copyright (c) 2014年 Aevitx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCDefines.h"

@protocol SCCameraNavigationControllerDelegate;

@interface SCCameraNavigationController : UINavigationController


- (void)showCameraWithParentController:(UIViewController*)parentController;

@property (nonatomic, assign) id <SCCameraNavigationControllerDelegate> cameraDelegate;

@end



@protocol SCCameraNavigationControllerDelegate <NSObject>
@optional
- (BOOL)willDismissNavigationController:(SCCameraNavigationController*)navigatonController;

- (void)didTakePicture:(SCCameraNavigationController*)navigationController image:(UIImage*)image;

@end