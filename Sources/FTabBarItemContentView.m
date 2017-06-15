//
//  FTabBarItemContentView.m
//  FTabBarController
//
//  Created by Fmyz on 2017/6/12.
//  Copyright © 2017年 Fmyz. All rights reserved.
//

#import "FTabBarItemContentView.h"
#import "FTabBarItemBadgeView.h"

#define default_textColor [UIColor colorWithWhite:0.57254902 alpha:1.0]
#define default_highlightTextColor [UIColor colorWithRed:10/255.0 green:96.0/255.0 blue:254/255.0 alpha:1.0]

#define default_iconColor [UIColor clearColor]
#define default_highlightIconColor  [UIColor clearColor]

#define default_backdropColor [UIColor clearColor]
#define default_highlightBackdropColor [UIColor clearColor]

@interface FTabBarItemContentView ()

@property (strong, nonatomic) UILabel *titleLabel;

@property (strong, nonatomic) UIImageView *imageView;

@property (strong, nonatomic) FTabBarItemBadgeView *badgeView;

@end

@implementation FTabBarItemContentView

- (instancetype)init
{
    if (self = [super init]) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews
{
    self.userInteractionEnabled = YES;
    
    _insets = UIEdgeInsetsZero;
    _selected = NO;
    _highlighted = NO;
    _highlightEnabled = YES;
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _imageView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.imageView];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.textColor = default_textColor;
    _titleLabel.font = [UIFont systemFontOfSize:10.0f];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.titleLabel];
    
    _textColor = default_textColor;
    _highlightTextColor = default_highlightTextColor;
    _iconColor = default_iconColor;
    _highlightIconColor = default_highlightIconColor;
    _backdropColor = default_backdropColor;
    _highlightBackdropColor = default_highlightBackdropColor;
}

- (void)setTextColor:(UIColor *)textColor
{
    _textColor = textColor;
    if (!_selected) {
        _titleLabel.textColor = textColor;
    }
}

- (void)setHighlightTextColor:(UIColor *)highlightTextColor
{
    _highlightTextColor = highlightTextColor;
    if (_selected) {
        _titleLabel.textColor = highlightTextColor;
    }
}

- (void)setIconColor:(UIColor *)iconColor
{
    _iconColor = iconColor;
    if (!_selected) {
        _imageView.tintColor = iconColor;
    }
}

- (void)setHighlightIconColor:(UIColor *)highlightIconColor
{
    _highlightIconColor = highlightIconColor;
    if (_selected) {
        _imageView.tintColor = highlightIconColor;
    }
}

- (void)setBackdropColor:(UIColor *)backdropColor
{
    _backdropColor = backdropColor;
    if (!_selected) {
        self.backgroundColor = backdropColor;
    }
}

- (void)setHighlightBackdropColor:(UIColor *)highlightBackdropColor
{
    _highlightBackdropColor = highlightBackdropColor;
    if (_selected) {
        self.backgroundColor = highlightBackdropColor;
    }
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    self.titleLabel.text = title;
    [self updateLayout];
}

- (void)setRenderingMode:(UIImageRenderingMode)renderingMode
{
    _renderingMode = renderingMode;
    [self updateDisplay];
}

- (void)setImage:(UIImage *)image
{
    _image = image;
    if (!_selected) {
        [self updateDisplay];
    }
}

- (void)setSelectedImage:(UIImage *)selectedImage
{
    _selectedImage = selectedImage;
    if (_selected) {
        [self updateDisplay];
    }
}

- (void)setBadgeValue:(NSString *)badgeValue
{
    _badgeValue = badgeValue;
    if (badgeValue) {
        if (_badgeView && _badgeView.superview) {
            [_badgeView removeFromSuperview];
        }
        [self addSubview:self.badgeView];
        self.badgeView.badgeValue = badgeValue;
        
        [self updateLayout];
    } else {
        [_badgeView removeFromSuperview];
    }
    
    [self badgeChangedWithAnimated:YES completion:nil];
}

- (void)setBadgeColor:(UIColor *)badgeColor
{
    _badgeColor = badgeColor;
    if (!_badgeView) {
        return;
    }
    if (badgeColor) {
        self.badgeView.badgeColor = badgeColor;
    } else {
        self.badgeView.badgeColor = defaultBadgeColor;
    }
}

- (void)setBadgeOffset:(UIOffset)badgeOffset
{
    if (!UIOffsetEqualToOffset(_badgeOffset, badgeOffset)) {
        _badgeOffset = badgeOffset;
        [self updateLayout];
    }
}

- (void)updateDisplay
{
    _imageView.image = [(_selected ? (_selectedImage ? _selectedImage : _image) : _image) imageWithRenderingMode:_renderingMode];
    _imageView.tintColor = _selected ? _highlightIconColor : _iconColor;
    _titleLabel.textColor = _selected ? _highlightTextColor : _textColor;
    self.backgroundColor = _selected ? _highlightBackdropColor : _backdropColor;
}

- (void)updateLayout
{
    
    CGFloat w = CGRectGetWidth(self.bounds);
    CGFloat h = CGRectGetHeight(self.bounds);
    
    _imageView.hidden = (_imageView.image == nil);
    _titleLabel.hidden = (_titleLabel.text == nil);
    
    if (!_imageView.isHidden && !_titleLabel.isHidden) {
        [_titleLabel sizeToFit];
        [_imageView sizeToFit];
        
        _titleLabel.frame = CGRectMake(w - CGRectGetWidth(_titleLabel.bounds) / 2.0f, h - CGRectGetHeight(_titleLabel.bounds) - 1.0f, CGRectGetWidth(_titleLabel.bounds), CGRectGetHeight(_titleLabel.bounds));
        _imageView.frame = CGRectMake(w - CGRectGetWidth(_imageView.bounds) / 2.0f, (h - CGRectGetHeight(_imageView.bounds)) / 2.0 - 6.0, CGRectGetWidth(_titleLabel.bounds), CGRectGetHeight(_imageView.bounds));
    } else if (!_imageView.isHidden) {
        [_imageView sizeToFit];
        _imageView.center = CGPointMake(w / 2.0, h / 2.0);
    } else if (!_titleLabel.isHidden) {
        [_titleLabel sizeToFit];
        _titleLabel.center = CGPointMake(w / 2.0, h / 2.0);
    }
    
    if (_badgeView.superview) {
        CGSize size = [_badgeView sizeThatFits:self.frame.size];
        _badgeView.frame = CGRectMake(w / 2.0 + _badgeOffset.horizontal, h / 2.0 + _badgeOffset.vertical, size.width, size.height);
        [_badgeView setNeedsLayout];
    }
}

- (void)selectWithAnimated:(BOOL)animated completion:(void (^)(void))completion
{
    _selected = YES;
    
    if (_highlightEnabled && _highlighted) {
        _highlighted = NO;
        
        __weak typeof(self) weakSelf = self;
        [self dehighlightAnimationWithAnimated:animated completion:^{
            [weakSelf updateDisplay];
            [weakSelf selectAnimationWithAnimated:animated completion:completion];
        }];
    } else {
        [self updateDisplay];
        [self selectAnimationWithAnimated:animated completion:completion];
    }
}
- (void)deselectWithAnimated:(BOOL)animated completion:(void (^)(void))completion
{
    _selected = NO;
    [self updateDisplay];
    [self deselectAnimationWithAnimated:animated completion:completion];
}
- (void)reselectWithAnimated:(BOOL)animated completion:(void (^)(void))completion
{
    if (_selected) {
        if (_highlightEnabled && _highlighted) {
            _highlighted = NO;
            
            __weak typeof(self) weakSelf = self;
            [self dehighlightAnimationWithAnimated:animated completion:^{
                [weakSelf reselectAnimationWithAnimated:animated completion:completion];
            }];
        } else {
            [self reselectAnimationWithAnimated:animated completion:completion];
        }
    } else {
        [self selectWithAnimated:animated completion:completion];
    }
}
- (void)highlightWithAnimated:(BOOL)animated completion:(void (^)(void))completion
{
    if (!_highlightEnabled) {
        return;
    }
    if (_highlighted) {
        return;
    }
    _highlighted = YES;
    [self highlightAnimationWithAnimated:animated completion:completion];
}
- (void)dehighlightWithAnimated:(BOOL)animated completion:(void (^)(void))completion
{
    if (!_highlightEnabled) {
        return;
    }
    if (!_highlighted) {
        return;
    }
    _highlighted = NO;
    [self dehighlightAnimationWithAnimated:animated completion:completion];
}
- (void)badgeChangedWithAnimated:(BOOL)animated completion:(void (^)(void))completion
{
    [self badgeChangedAnimationWithAnimated:animated completion:completion];
}
- (void)selectAnimationWithAnimated:(BOOL)animated completion:(void (^)(void))completion
{
    if (completion) {
        completion();
    }
}
- (void)deselectAnimationWithAnimated:(BOOL)animated completion:(void (^)(void))completion
{
    if (completion) {
        completion();
    }
}
- (void)reselectAnimationWithAnimated:(BOOL)animated completion:(void (^)(void))completion
{
    if (completion) {
        completion();
    }
}
- (void)highlightAnimationWithAnimated:(BOOL)animated completion:(void (^)(void))completion
{
    if (completion) {
        completion();
    }
}
- (void)dehighlightAnimationWithAnimated:(BOOL)animated completion:(void (^)(void))completion
{
    if (completion) {
        completion();
    }
}
- (void)badgeChangedAnimationWithAnimated:(BOOL)animated completion:(void (^)(void))completion
{
    if (completion) {
        completion();
    }
}

- (FTabBarItemBadgeView *)badgeView
{
    if (!_badgeView) {
        _badgeView = [[FTabBarItemBadgeView alloc] init];
    }
    return _badgeView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
