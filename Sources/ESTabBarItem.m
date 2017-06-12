//
//  ESTabBarItem.m
//  ContactsA
//
//  Created by Fmyz on 2017/6/5.
//  Copyright © 2017年 Fmyz. All rights reserved.
//

#import "ESTabBarItem.h"

@implementation ESTabBarItem

- (instancetype)init:(ESTabBarItemContentView *)contentView title:(NSString *)title image:(UIImage *)image selectedImage:(UIImage *)selectedImage tag:(NSInteger)tag
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
    }
}

- (void)setImage:(UIImage *)image
{
    if (_contentView) {
        _contentView.image = image;
    }
}

- (void)setSelectedImage:(UIImage *)selectedImage
{
    if (_contentView) {
        _contentView.selectedImage = selectedImage;
    }
}

- (void)setBadgeValue:(NSString *)badgeValue
{
//    [super setBadgeValue:badgeValue];
    if (_contentView) {
        _contentView.badgeValue = badgeValue;
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
//    [super setBadgeColor:badgeColor];
    if (_contentView) {
        _contentView.badgeColor = badgeColor;
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
    [super setTag:tag];
    if (_contentView) {
        _contentView.tag = tag;
    }
}

@end
