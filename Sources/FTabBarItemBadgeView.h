//
//  FTabBarItemBadgeView.h
//  FTabBarController
//
//  Created by Fmyz on 2017/6/12.
//  Copyright © 2017年 Fmyz. All rights reserved.
//

#import <UIKit/UIKit.h>

#define defaultBadgeColor [UIColor colorWithRed:251.0/255.0 green:32.0/255.0 blue:37.0/255.0 alpha:1.0]

@interface FTabBarItemBadgeView : UIView

@property (strong, nonatomic) UIColor *badgeColor;
@property (copy, nonatomic) NSString *badgeValue;

@end
