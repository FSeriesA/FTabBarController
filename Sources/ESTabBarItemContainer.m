//
//  ESTabBarItemContainer.m
//  ContactsA
//
//  Created by Fmyz on 2017/6/5.
//  Copyright © 2017年 Fmyz. All rights reserved.
//

#import "ESTabBarItemContainer.h"
#import "ESTabBarItemContentView.h"

@implementation ESTabBarItemContainer

- (instancetype)init:(id)target tag:(NSInteger)tag
{
    if (self = [super initWithFrame:CGRectZero]) {
        
        self.tag = tag;
        
        [self addTarget:target action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addTarget:target action:@selector(highlightAction:) forControlEvents:UIControlEventTouchDown];
        [self addTarget:target action:@selector(highlightAction:) forControlEvents:UIControlEventTouchDragEnter];
        [self addTarget:target action:@selector(dehighlightAction:) forControlEvents:UIControlEventTouchDragExit];
        
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    for (UIView *subview in self.subviews) {
        if ([subview isKindOfClass:[ESTabBarItemContentView class]]) {
//             subview.frame = CGRect.init(x: subview.insets.left, y: subview.insets.top, width: bounds.size.width - subview.insets.left - subview.insets.right, height: bounds.size.height - subview.insets.top - subview.insets.bottom)
            [(ESTabBarItemContentView *)subview updateLayout];
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

- (void)selectAction:(id)anyObject{}
- (void)highlightAction:(id)anyObject{}
- (void)dehighlightAction:(id)anyObject{}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
