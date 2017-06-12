//
//  ESTabBarItemBadgeView.h
//  ContactsA
//
//  Created by Fmyz on 2017/6/5.
//  Copyright © 2017年 Fmyz. All rights reserved.
//

#import <UIKit/UIKit.h>

#define defaultBadgeColor [UIColor colorWithRed:255.0/255.0 green:59.0/255.0 blue:48.0/255.0 alpha:1.0]

@interface ESTabBarItemBadgeView : UIView

@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UILabel *badgeLabel;
@property (strong, nonatomic) UIColor *badgeColor;
@property (copy, nonatomic) NSString *badgeValue;


@end
