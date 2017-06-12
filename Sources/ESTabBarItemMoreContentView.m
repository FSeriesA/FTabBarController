//
//  ESTabBarItemMoreContentView.m
//  ContactsA
//
//  Created by Fmyz on 2017/6/5.
//  Copyright © 2017年 Fmyz. All rights reserved.
//

#import "ESTabBarItemMoreContentView.h"

@implementation ESTabBarItemMoreContentView

- (instancetype)init
{
    if (self = [self initWithFrame:CGRectZero]) {
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.title = @"More";
        self.image = [self systemMoreWithHighlighted:NO];
        self.selectedImage = [self systemMoreWithHighlighted:YES];
    }
    return self;
}

- (UIImage *)systemMoreWithHighlighted:(BOOL)isHighlighted
{
    UIImage *image;
    
    CGFloat circleDiameter = isHighlighted ? 5.0 : 4.0;
    CGFloat scale = [[UIScreen mainScreen] scale];
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(32, 32), NO, scale);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (context) {
        CGContextSetLineWidth(context, 1.0);
        
        for (int index = 0; index <= 2; index++) {
            CGRect tmpRect = CGRectMake(5.0 + 9.0 * index, 14.0, circleDiameter, circleDiameter);
            CGContextAddEllipseInRect(context, tmpRect);
            [image drawInRect:tmpRect];
        }
        
        if (isHighlighted) {
            CGColorSpaceRef colorSpace = CGColorGetColorSpace([UIColor blueColor].CGColor);
            CGContextSetFillColorSpace(context, colorSpace);
            CGContextFillPath(context);
            
            CGColorSpaceRelease(colorSpace);
        } else {
            CGContextStrokePath(context);
        }
        
        CGContextRelease(context);
        
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return image;
    }
    return nil;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
