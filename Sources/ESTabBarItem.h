//
//  ESTabBarItem.h
//  ContactsA
//
//  Created by Fmyz on 2017/6/5.
//  Copyright © 2017年 Fmyz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ESTabBarItemContentView.h"

@interface ESTabBarItem : UITabBarItem

@property (nonatomic, strong) ESTabBarItemContentView *contentView;

- (instancetype)init:(ESTabBarItemContentView *)contentView title:(NSString *)title image:(UIImage *)image selectedImage:(UIImage *)selectedImage tag:(NSInteger)tag;

- (void)setTitle:(NSString *)title image:(UIImage *)image selectedImage:(UIImage *)selectedImage tag:(NSInteger)tag;

@end
