//
//  ESTabBar.m
//  ContactsA
//
//  Created by Fmyz on 2017/6/5.
//  Copyright © 2017年 Fmyz. All rights reserved.
//

#import "ESTabBar.h"
#import "ESTabBarController.h"


@implementation ESTabBar

@synthesize moreContentView = _moreContentView;

- (void)setItems:(NSArray<UITabBarItem *> *)items animated:(BOOL)animated
{
    [super setItems:items animated:animated];
    [self reload];
}
- (void)beginCustomizingItems:(NSArray<UITabBarItem *> *)items
{
    [super beginCustomizingItems:items];
}
- (BOOL)endCustomizingAnimated:(BOOL)animated
{
    return [super endCustomizingAnimated:animated];
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    [self updateLayout];
}
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    BOOL b = [super pointInside:point withEvent:event];
    if (!b) {
        for (ESTabBarItemContainer *container in _containers) {
            if ([container pointInside:CGPointMake(point.x - container.frame.origin.x, point.y - container.frame.origin.y) withEvent:event]) {
                b = YES;
            }
        }
    }
    return b;
}

- (void)setItemCustomPositioning:(ESTabBarItemPositioning)itemCustomPositioning
{
    _itemCustomPositioning = itemCustomPositioning;
    switch (itemCustomPositioning) {
        case ESTabBarItemPositioningFill:
        case ESTabBarItemPositioningAutomatic:
        case ESTabBarItemPositioningCentered:
            self.itemPositioning = (UITabBarItemPositioning)itemCustomPositioning;
            break;
            
        default:
            break;
    }
    [self reload];
}

- (void)setMoreContentView:(ESTabBarItemMoreContentView *)moreContentView
{
    _moreContentView = moreContentView;
    [self reload];
}

- (void)setItems:(NSArray<UITabBarItem *> *)items
{
    [super setItems:items];
    [self reload];
}

- (void)setIsEditing:(BOOL)isEditing
{
    if (_isEditing != isEditing) {
        [self updateLayout];
    }
}
- (NSMutableArray<ESTabBarItemContainer *> *)containers
{
    if (!_containers) {
        _containers = [[NSMutableArray alloc] init];
    }
    return _containers;
}
- (ESTabBarItemMoreContentView *)moreContentView
{
    if (!_moreContentView) {
        _moreContentView = [[ESTabBarItemMoreContentView alloc] init];
    }
    return _moreContentView;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

@implementation ESTabBar (Layout)

- (void)updateLayout
{
    NSArray *tabBarItems = self.items;
    if (!tabBarItems) {
        return;
    }
    NSArray<UIView *> *tabBarButtons = [[self.subviews filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        return [evaluatedObject isKindOfClass:NSClassFromString(@"UITabBarButton")];
    }]] sortedArrayUsingComparator:^NSComparisonResult(UIView *subview1, UIView *subview2) {
        return subview1.frame.origin.x < subview2.frame.origin.x;
    }];
    
    __weak typeof(self) weakSelf = self;
    __weak typeof(_moreContentView) weakMoreContentView = _moreContentView;
    if (self.isCustomizing) {
        
        [tabBarItems enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            tabBarButtons[idx].hidden = NO;
            weakMoreContentView.hidden = YES;
        }];
        
        [self.containers enumerateObjectsUsingBlock:^(ESTabBarItemContainer * _Nonnull container, NSUInteger idx, BOOL * _Nonnull stop) {
            container.hidden = YES;
        }];
    } else {
        [tabBarItems enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:NSClassFromString(@"ESTabBarItem")]) {
                tabBarButtons[idx].hidden = YES;
            } else {
                tabBarButtons[idx].hidden = NO;
            }
            
            if ([weakSelf isMoreItem:idx] && weakMoreContentView) {
                tabBarButtons[idx].hidden = YES;
            }
        }];
        
        [self.containers enumerateObjectsUsingBlock:^(ESTabBarItemContainer * _Nonnull container, NSUInteger idx, BOOL * _Nonnull stop) {
            container.hidden = NO;
        }];
    }
    
    BOOL layoutBaseSystem = YES;
    
    ESTabBarItemPositioning itemCustomPositioning = _itemCustomPositioning;
    switch (itemCustomPositioning) {
        case ESTabBarItemPositioningFill:
        case ESTabBarItemPositioningAutomatic:
        case ESTabBarItemPositioningCentered:
            break;
        case ESTabBarItemPositioningFillIncludeSeparator:
        case ESTabBarItemPositioningFillExcludeSeparator:
            layoutBaseSystem = NO;
            break;
        default:
            break;
    }
    
    if (layoutBaseSystem) {
        [self.containers enumerateObjectsUsingBlock:^(ESTabBarItemContainer * _Nonnull container, NSUInteger idx, BOOL * _Nonnull stop) {
            container.frame = tabBarButtons[idx].frame;
        }];
    } else {
        CGFloat x = _itemEdgeInsets.left;
        CGFloat y = _itemEdgeInsets.top;
        switch (itemCustomPositioning) {
            case ESTabBarItemPositioningFillExcludeSeparator:
            {
                if (y <= 0.0f) {
                    y += 1.0f;
                }
            }
                break;
            default:
                break;
        }
        
        CGFloat width = CGRectGetWidth(self.bounds) - x - _itemEdgeInsets.right;
        CGFloat height = CGRectGetWidth(self.bounds) - y - _itemEdgeInsets.bottom;
        CGFloat eachWidth = self.itemWidth == 0.0 ? width / _containers.count : self.itemWidth;
        CGFloat eachSpacing = self.itemSpacing == 0.0 ? 0.0 : self.itemSpacing;
        
        for (ESTabBarItemContainer *container in _containers) {
            container.frame = CGRectMake(x, y, eachWidth, height);
            x += eachWidth;
            x += eachSpacing;
        }
    }
}

@end

@implementation ESTabBar (Actions)

- (BOOL)isMoreItem:(NSInteger)index
{
    NSInteger index2 = (self.items?(self.items.count)?self.items.count:0:0) - 1;
    return [ESTabBarController isShowingMore:_tabBarController] && (index == index2);
}

- (void)removeAll
{
    for (ESTabBarItemContainer *container in self.containers) {
        [container removeFromSuperview];
    }
    [self.containers removeAllObjects];
}

- (void)reload
{
    [self removeAll];

    NSArray<UITabBarItem *> *tabBarItems = self.items;
    if (!tabBarItems) {
        [ESTabBarController printError:@"empty items"];
        return;
    }
    
    [tabBarItems enumerateObjectsUsingBlock:^(UITabBarItem * _Nonnull item, NSUInteger idx, BOOL * _Nonnull stop) {
        ESTabBarItemContainer *container = [[ESTabBarItemContainer alloc] init:self tag:1000 + idx];
        [self addSubview:container];
        [self.containers addObject:container];
        
        if ([item isKindOfClass:[ESTabBarItem class]]) {
            UIView *contentView = ((ESTabBarItem *)item).contentView;
            if (contentView) {
                [container addSubview:contentView];
            }
        }
        if ([self isMoreItem:idx]) {
            UIView *moreContentView = self.moreContentView;
            [container addSubview:moreContentView];
        }
    }];
    
    [self setNeedsLayout];
}

- (void)highlightAction:(id)sender
{
    UIView *container = sender;
    if (![container isKindOfClass:[ESTabBarItemContainer class]]) {
        return;
    }
    
    if (!self.items) {
        return;
    }
    NSInteger newIndex = MAX(0, container.tag - 1000);
    if (newIndex >= self.items.count?self.items.count:0) {
        return;
    }
    UITabBarItem *item = [self.items objectAtIndex:newIndex];
    if (!item.isEnabled) {
        return;
    }
    
    if (!self.customDelegate || ![self.customDelegate tabBar:self shouldSelectItem:item]) {
        return;
    }
    
    if ([item isKindOfClass:[ESTabBarItem class]]) {
        ESTabBarItemContentView *contentView = ((ESTabBarItem *)item).contentView;
        if (contentView) {
            [contentView highlightWithAnimated:YES completion:nil];
        }
    } else if ([self isMoreItem:newIndex]) {
        ESTabBarItemContentView *moreContentView = _moreContentView;
        if (moreContentView) {
            [moreContentView highlightWithAnimated:YES completion:nil];
        }
    }

}
- (void)dehighlightAction:(id)sender
{
    UIView *container = sender;
    if (![container isKindOfClass:[ESTabBarItemContainer class]]) {
        return;
    }
    
    if (!self.items) {
        return;
    }
    NSInteger newIndex = MAX(0, container.tag - 1000);
    if (newIndex >= self.items.count?self.items.count:0) {
        return;
    }
    UITabBarItem *item = [self.items objectAtIndex:newIndex];
    if (!item.isEnabled) {
        return;
    }
    
    if (!self.customDelegate || ![self.customDelegate tabBar:self shouldSelectItem:item]) {
        return;
    }
    
    if ([item isKindOfClass:[ESTabBarItem class]]) {
        ESTabBarItemContentView *contentView = ((ESTabBarItem *)item).contentView;
        if (contentView) {
            [contentView dehighlightWithAnimated:YES completion:nil];
        }
    } else if ([self isMoreItem:newIndex]) {
        ESTabBarItemContentView *moreContentView = _moreContentView;
        if (moreContentView) {
            [moreContentView dehighlightWithAnimated:YES completion:nil];
        }
    }

}
- (void)selectAction:(id)sender
{
    UIView *container = sender;
    if (![container isKindOfClass:[ESTabBarItemContainer class]]) {
        return;
    }
    
    [self selectWithItemAtIndex:container.tag - 1000 animated:YES];
}
- (void)selectWithItemAtIndex:(NSInteger)idx animated:(BOOL)animated
{
    NSInteger newIndex = MAX(0, idx);
    NSInteger currentIndex = (self.selectedItem != nil)?(self.items?[self.items indexOfObject:self.selectedItem]:-1):-1;
    
    if (!self.items) {
        return;
    }
    if (newIndex >= self.items.count?self.items.count:0) {
        return;
    }
    UITabBarItem *item = [self.items objectAtIndex:newIndex];
    if (!item.isEnabled) {
        return;
    }
    
    if (!self.customDelegate || ![self.customDelegate tabBar:self shouldSelectItem:item]) {
        return;
    }
    
    if (self.customDelegate && [self.customDelegate tabBar:self shouldHijackItem:item]) {
        if (animated) {
            if ([item isKindOfClass:[ESTabBarItem class]]) {
                ESTabBarItemContentView *contentView = ((ESTabBarItem *)item).contentView;
                if (contentView) {
                    __weak typeof(contentView) weakContentView = contentView;
                    [contentView selectWithAnimated:animated completion:^{
                        [weakContentView deselectWithAnimated:NO completion:nil];
                    }];
                }
            } else if ([self isMoreItem:newIndex]) {
                ESTabBarItemContentView *moreContentView = self.moreContentView;
                if (moreContentView) {
                    __weak typeof(moreContentView) weakMoreContentView = moreContentView;
                    [moreContentView selectWithAnimated:animated completion:^{
                        [weakMoreContentView deselectWithAnimated:animated completion:nil];
                    }];
                }
            }
        }
        return;
    }
    
    if (currentIndex != newIndex) {
        if (currentIndex != -1 && currentIndex < (self.items?self.items.count:0)) {
            UITabBarItem *currentItem = [self.items objectAtIndex:currentIndex];
            if ([currentItem isKindOfClass:[ESTabBarItem class]]) {
                ESTabBarItemContentView *contentView = ((ESTabBarItem *)currentItem).contentView;
                [contentView deselectWithAnimated:animated completion:nil];
                
            } else if ([self isMoreItem:currentIndex]) {
                ESTabBarItemMoreContentView *moreContentView = _moreContentView;
                if (moreContentView) {
                    [moreContentView deselectWithAnimated:animated completion:nil];
                }
            }
        }
        
        if ([item isKindOfClass:[ESTabBarItem class]]) {
            ESTabBarItemContentView *contentView = ((ESTabBarItem *)item).contentView;
            [contentView selectWithAnimated:animated completion:nil];
        } else if ([self isMoreItem:newIndex]) {
            ESTabBarItemMoreContentView *moreContentView = _moreContentView;
            [moreContentView selectWithAnimated:animated completion:nil];
        }
        if (self.delegate) {
            [self.delegate tabBar:self didSelectItem:item];
        }
    } else if (currentIndex == newIndex) {
        if ([item isKindOfClass:[ESTabBarItem class]]) {
            ESTabBarItemContentView *contentView = ((ESTabBarItem *)item).contentView;
            [contentView reselectWithAnimated:animated completion:nil];
        } else if ([self isMoreItem:newIndex]) {
            ESTabBarItemMoreContentView *moreContentView = _moreContentView;
            [moreContentView reselectWithAnimated:animated completion:nil];
        }
        
        UITabBarController *tabBarController = _tabBarController;
        
        if (tabBarController && [tabBarController.selectedViewController isKindOfClass:[UINavigationController class]]) {
            
            UINavigationController *navVC = (UINavigationController *)tabBarController.selectedViewController;
            if ([navVC.viewControllers containsObject:tabBarController]) {
                if (navVC.viewControllers.count > 1 && [navVC.viewControllers lastObject] != tabBarController) {
                    [navVC popToViewController:tabBarController animated:YES];
                } else {
                    if (navVC.viewControllers.count > 1) {
                        [navVC popToRootViewControllerAnimated:animated];
                    }
                }
            }
        }
    }
}

@end
