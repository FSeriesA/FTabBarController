//
//  FTabBarItem.h
//  FTabBarController
//
//  Created by Fmyz on 2017/6/12.
//  Copyright © 2017年 Fmyz. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FTabBarItemContentView;

@interface FTabBarItem : UITabBarItem

@property (strong, nonatomic) FTabBarItemContentView *contentView;

- (instancetype)initWithContentView:(FTabBarItemContentView *)contentView title:(NSString *)title image:(UIImage *)image selectedImage:(UIImage *)selectedImage tag:(NSInteger)tag;

@end
