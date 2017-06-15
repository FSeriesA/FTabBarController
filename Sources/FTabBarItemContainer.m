//
//  FTabBarItemContainer.m
//  FTabBarController
//
//  Created by Fmyz on 2017/6/12.
//  Copyright © 2017年 Fmyz. All rights reserved.
//

#import "FTabBarItemContainer.h"
#import "FTabBarItemContentView.h"

@interface FTabBarItemContainer ()

@property (weak, nonatomic) id<FTabBarItemContainerDelegate> target;

@end

@implementation FTabBarItemContainer

- (instancetype)initWithTarget:(id<FTabBarItemContainerDelegate>)target tag:(NSInteger)tag
{
    if (self = [super init]) {
        self.backgroundColor = [UIColor clearColor];

        self.target = target;
        self.tag = tag;
        
        [self addTarget:self action:@selector(selectAction) forControlEvents:UIControlEventTouchUpInside];
        [self addTarget:self action:@selector(highlightAction) forControlEvents:UIControlEventTouchDown];
        [self addTarget:self action:@selector(highlightAction) forControlEvents:UIControlEventTouchDragEnter];
        [self addTarget:self action:@selector(dehighlightAction) forControlEvents:UIControlEventTouchDragExit];
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    for (UIView *subview in self.subviews) {
        if ([subview isKindOfClass:[FTabBarItemContentView class]]) {
            
            FTabBarItemContentView *contentView = (FTabBarItemContentView *)subview;
            
            contentView.frame = CGRectMake(contentView.insets.left, contentView.insets.top, self.bounds.size.width - contentView.insets.left - contentView.insets.right, self.bounds.size.height - contentView.insets.top - contentView.insets.bottom);            
            [contentView updateLayout];
        }
    }
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    BOOL b = [super pointInside:point withEvent:event];
    if (!b) {
        for (UIView *subview in self.subviews) {
            if ([subview pointInside:CGPointMake(point.x - CGRectGetMinX(subview.frame), point.y - CGRectGetMinY(subview.frame)) withEvent:event]) {
                b = YES;
            }
        }
    }
    return b;
}

- (void)selectAction{
    if (self.target && [self.target respondsToSelector:@selector(selectAction:)]) {
        [self.target selectAction:self];
    }
}
- (void)highlightAction{
    if (self.target && [self.target respondsToSelector:@selector(highlightAction:)]) {
        [self.target selectAction:self];
    }
}
- (void)dehighlightAction{
    if (self.target && [self.target respondsToSelector:@selector(dehighlightAction:)]) {
        [self.target selectAction:self];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end


