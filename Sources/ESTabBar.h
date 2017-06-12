//
//  ESTabBar.h
//  ContactsA
//
//  Created by Fmyz on 2017/6/5.
//  Copyright © 2017年 Fmyz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ESTabBarItemContainer.h"
#import "ESTabBarItemMoreContentView.h"
#import "ESTabBarItem.h"

typedef NS_ENUM(int, ESTabBarItemPositioning) {

    ESTabBarItemPositioningAutomatic = UITabBarItemPositioningAutomatic,
    ESTabBarItemPositioningFill = UITabBarItemPositioningFill,
    ESTabBarItemPositioningCentered = UITabBarItemPositioningCentered,
    ESTabBarItemPositioningFillExcludeSeparator,
    ESTabBarItemPositioningFillIncludeSeparator,
};

@protocol ESTabBarDelegate <NSObject>

- (BOOL)tabBar:(UITabBar *)tabBar shouldSelectItem:(UITabBarItem *)item;
- (BOOL)tabBar:(UITabBar *)tabBar shouldHijackItem:(UITabBarItem *)item;
- (void)tabBar:(UITabBar *)tabBar didHijackItem:(UITabBarItem *)item;

@end

@interface ESTabBar : UITabBar

@property (weak, nonatomic) id<ESTabBarDelegate> customDelegate;
@property (nonatomic) UIEdgeInsets itemEdgeInsets;
@property (assign, nonatomic) ESTabBarItemPositioning itemCustomPositioning;
/// tabBar自定义item的容器view
@property (nonatomic, strong) NSMutableArray<ESTabBarItemContainer *> *containers;
@property (nonatomic, weak) UITabBarController *tabBarController;
@property (nonatomic, strong) ESTabBarItemMoreContentView *moreContentView;
@property (nonatomic) BOOL isEditing;

@end

@interface ESTabBar (Layout)

- (void)updateLayout;

@end

@interface ESTabBar (Actions)

- (BOOL)isMoreItem:(NSInteger)index;
- (void)removeAll;
- (void)reload;
- (void)highlightAction:(id)sender;
- (void)dehighlightAction:(id)sender;
- (void)selectAction:(id)sender;
- (void)selectWithItemAtIndex:(NSInteger)idx animated:(BOOL)animated;

@end
