//
//  FTabBarController.h
//  FTabBarController
//
//  Created by Fmyz on 2017/6/12.
//  Copyright © 2017年 Fmyz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FTabBarController : UITabBarController

@end



@interface FTabBarController (MutableViewControllers)

- (void)addViewController:(UIViewController *)viewController animated:(BOOL)animated;

- (void)insertViewController:(UIViewController *)viewController atIndex:(NSInteger)index animated:(BOOL)animated;

- (void)removeViewController:(UIViewController *)viewController animated:(BOOL)animated;

- (void)removeViewControllerAtIndex:(NSInteger)index animated:(BOOL)animated;

@end
