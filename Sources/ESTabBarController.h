//
//  ESTabBarController.h
//  ContactsA
//
//  Created by Fmyz on 2017/6/5.
//  Copyright © 2017年 Fmyz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ESTabBar.h"

typedef BOOL (^ESTabBarControllerShouldHijackHandler)(UITabBarController *tabBarController, UIViewController *viewController, NSInteger index);
typedef void (^ESTabBarControllerDidHijackHandler)(UITabBarController *tabBarController, UIViewController *viewController, NSInteger index);


@interface ESTabBarController : UITabBarController <ESTabBarDelegate>

@property (nonatomic, copy) ESTabBarControllerShouldHijackHandler shouldHijackHandler;
@property (nonatomic, copy) ESTabBarControllerDidHijackHandler didHijackHandler;

+ (BOOL)isShowingMore:(UITabBarController *)tabBarController;

+ (void)printError:(NSString *)description;

@end
