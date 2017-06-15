//
//  FTabBarItem.m
//  FTabBarController
//
//  Created by Fmyz on 2017/6/12.
//  Copyright © 2017年 Fmyz. All rights reserved.
//

#import "FTabBarItem.h"
#import "FTabBarItemContentView.h"

@implementation FTabBarItem

- (instancetype)initWithContentView:(FTabBarItemContentView *)contentView title:(NSString *)title image:(UIImage *)image selectedImage:(UIImage *)selectedImage tag:(NSInteger)tag
{
    if (self = [super init]) {
        self.contentView = contentView;
        [self setTitle:title image:image selectedImage:selectedImage tag:tag];
    }
    return self;
}

- (void)setTitle:(NSString *)title image:(UIImage *)image selectedImage:(UIImage *)selectedImage tag:(NSInteger)tag
{
    self.title = title;
    self.image = image;
    self.selectedImage = selectedImage;
    self.tag = tag;
}

- (void)setTitle:(NSString *)title
{
    
    if (_contentView) {
        _contentView.title = title;
    } else {
        [super setTitle:title];
    }
}

- (void)setImage:(UIImage *)image
{
    if (_contentView) {
        _contentView.image = image;
    } else {
        [super setImage:image];
    }
}

- (void)setSelectedImage:(UIImage *)selectedImage
{
    if (_contentView) {
        _contentView.selectedImage = selectedImage;
    } else {
        [super setSelectedImage:selectedImage];
    }
}

- (void)setBadgeValue:(NSString *)badgeValue
{
    
    if (_contentView) {
        _contentView.badgeValue = badgeValue;
    } else {
        [super setBadgeValue:badgeValue];
    }
}

- (NSString *)badgeValue
{
    if (_contentView) {
        return _contentView.badgeValue;
    }
    return [super badgeValue];
}

- (void)setBadgeColor:(UIColor *)badgeColor
{
    
    if (_contentView) {
        _contentView.badgeColor = badgeColor;
    } else {
        [super setBadgeColor:badgeColor];
    }
}

- (UIColor *)badgeColor
{
    if (_contentView) {
        return _contentView.badgeColor;
    }
    return [super badgeColor];
}

- (void)setTag:(NSInteger)tag
{
    
    if (_contentView) {
        _contentView.tag = tag;
    } else {
        [super setTag:tag];
    }
}

@end
