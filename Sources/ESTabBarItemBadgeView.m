//
//  ESTabBarItemBadgeView.m
//  ContactsA
//
//  Created by Fmyz on 2017/6/5.
//  Copyright © 2017年 Fmyz. All rights reserved.
//

#import "ESTabBarItemBadgeView.h"

@implementation ESTabBarItemBadgeView

- (instancetype)init
{
    if (self = [super init]) {
        [self addSubview:self.imageView];
        [self addSubview:self.badgeLabel];
        self.badgeColor = defaultBadgeColor;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.imageView];
        [self addSubview:self.badgeLabel];
        self.badgeColor = defaultBadgeColor;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (!_badgeValue) {
        _imageView.hidden = YES;
        _badgeLabel.hidden = YES;
        return;
    }
    
    _imageView.hidden = NO;
    _badgeLabel.hidden = NO;

    if (_badgeValue.length == 0) {
        _imageView.frame = CGRectMake((CGRectGetWidth(self.bounds) - 8.0) / 2.0, (CGRectGetHeight(self.bounds) - 8.0) / 2.0, 8.0f, 8.0f);
    } else {
        _imageView.frame = self.bounds;
    }
    
    _imageView.layer.cornerRadius = CGRectGetHeight(_imageView.bounds) / 2.0f;
    [_badgeLabel sizeToFit];
    _badgeLabel.center = _imageView.center;
}

- (CGSize)sizeThatFits:(CGSize)size
{
    if (!_badgeValue) {
        return CGSizeMake(18.0f, 18.0f);
    }
    
    CGSize textSize = [_badgeLabel sizeThatFits:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)];
    return CGSizeMake(MAX(18.0f, textSize.width + 10.0f), 18.0f);
}

- (void)setBadgeValue:(NSString *)badgeValue
{
    _badgeValue = badgeValue;
    _badgeLabel.text = badgeValue;
}

- (void)setBadgeColor:(UIColor *)badgeColor
{
    _badgeColor = badgeColor;
    _imageView.backgroundColor = badgeColor;
}

- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _imageView.backgroundColor = [UIColor clearColor];
    }
    return _imageView;
}

- (UILabel *)badgeLabel
{
    if (!_badgeLabel) {
        _badgeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _badgeLabel.backgroundColor = [UIColor clearColor];
        _badgeLabel.textColor = [UIColor whiteColor];
        _badgeLabel.font = [UIFont systemFontOfSize:13.0f];
        _badgeLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _badgeLabel;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
