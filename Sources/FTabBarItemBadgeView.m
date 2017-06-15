//
//  FTabBarItemBadgeView.m
//  FTabBarController
//
//  Created by Fmyz on 2017/6/12.
//  Copyright © 2017年 Fmyz. All rights reserved.
//

#import "FTabBarItemBadgeView.h"

@interface FTabBarItemBadgeView ()

@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UILabel *badgeLabel;

@end

@implementation FTabBarItemBadgeView

- (instancetype)init
{
    if (self = [super init]) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews
{
    _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _imageView.backgroundColor = defaultBadgeColor;
    [self addSubview:self.imageView];
    
    _badgeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _badgeLabel.backgroundColor = [UIColor clearColor];
    _badgeLabel.textColor = [UIColor whiteColor];
    _badgeLabel.font = [UIFont systemFontOfSize:13.0f];
    _badgeLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.badgeLabel];
    
    _badgeColor = defaultBadgeColor;
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
