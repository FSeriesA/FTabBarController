//
//  ESTabBarItemContentView.h
//  ContactsA
//
//  Created by Fmyz on 2017/6/5.
//  Copyright © 2017年 Fmyz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ESTabBarItemBadgeView.h"

@interface ESTabBarItemContentView : UIView

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

@property (strong, nonatomic) UILabel *titleLabel;
@property (copy, nonatomic) NSString *title;

@property (strong, nonatomic) UIImageView *imageView;
@property (assign, nonatomic) UIImageRenderingMode renderingMode;
@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) UIImage *selectedImage;

@property (strong, nonatomic) ESTabBarItemBadgeView *badgeView;
@property (copy, nonatomic) NSString *badgeValue;
@property (strong, nonatomic) UIColor *badgeColor;
@property (nonatomic) UIOffset badgeOffset;

- (void)updateDisplay;
- (void)updateLayout;

- (void)selectWithAnimated:(BOOL)animated completion:(void (^)(void))completion;
- (void)deselectWithAnimated:(BOOL)animated completion:(void (^)(void))completion;
- (void)reselectWithAnimated:(BOOL)animated completion:(void (^)(void))completion;
- (void)highlightWithAnimated:(BOOL)animated completion:(void (^)(void))completion;
- (void)dehighlightWithAnimated:(BOOL)animated completion:(void (^)(void))completion;
- (void)badgeChangedWithAnimated:(BOOL)animated completion:(void (^)(void))completion;
//- (void)selectAnimationWithAnimated:(BOOL)animated completion:(void (^)(void))completion;
//- (void)deselectAnimationWithAnimated:(BOOL)animated completion:(void (^)(void))completion;
//- (void)reselectAnimationWithAnimated:(BOOL)animated completion:(void (^)(void))completion;
//- (void)highlightAnimationWithAnimated:(BOOL)animated completion:(void (^)(void))completion;
//- (void)dehighlightAnimationWithAnimated:(BOOL)animated completion:(void (^)(void))completion;
//- (void)badgeChangedAnimationWithAnimated:(BOOL)animated completion:(void (^)(void))completion;

@end
