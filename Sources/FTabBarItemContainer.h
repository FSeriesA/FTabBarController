//
//  FTabBarItemContainer.h
//  FTabBarController
//
//  Created by Fmyz on 2017/6/12.
//  Copyright © 2017年 Fmyz. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FTabBarItemContainerDelegate;
@interface FTabBarItemContainer : UIControl

- (instancetype)initWithTarget:(id<FTabBarItemContainerDelegate>)target tag:(NSInteger)tag;

@end


@protocol FTabBarItemContainerDelegate <NSObject>

@optional
- (void)selectAction:(FTabBarItemContainer *)container;

- (void)highlightAction:(FTabBarItemContainer *)container;

- (void)dehighlightAction:(FTabBarItemContainer *)container;

@end
