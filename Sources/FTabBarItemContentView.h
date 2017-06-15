//
//  FTabBarItemContentView.h
//  FTabBarController
//
//  Created by Fmyz on 2017/6/12.
//  Copyright © 2017年 Fmyz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FTabBarItemContentView : UIView

/// 设置contentView的偏移
@property (nonatomic) UIEdgeInsets insets;
/// 是否被选中
@property (nonatomic) BOOL selected;
/// 是否处于高亮状态
@property (nonatomic) BOOL highlighted;
/// 是否支持高亮
@property (nonatomic) BOOL highlightEnabled;

/// 文字颜色
@property (strong, nonatomic) UIColor *textColor;
/// 高亮时文字颜色
@property (strong, nonatomic) UIColor *highlightTextColor;
/// icon颜色
@property (strong, nonatomic) UIColor *iconColor;
/// 高亮时icon颜色
@property (strong, nonatomic) UIColor *highlightIconColor;
/// 背景颜色
@property (strong, nonatomic) UIColor *backdropColor;
/// 高亮时背景颜色
@property (strong, nonatomic) UIColor *highlightBackdropColor;

@property (copy, nonatomic) NSString *title;

@property (assign, nonatomic) UIImageRenderingMode renderingMode;
@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) UIImage *selectedImage;

@property (copy, nonatomic) NSString *badgeValue;
@property (strong, nonatomic) UIColor *badgeColor;
@property (nonatomic) UIOffset badgeOffset;

- (void)updateLayout;

@end
