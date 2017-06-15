//
//  FTabBar.m
//  FTabBarController
//
//  Created by Fmyz on 2017/6/12.
//  Copyright © 2017年 Fmyz. All rights reserved.
//

#import "FTabBar.h"
#import "FTabBarItemContainer.h"

@interface FTabBar () <FTabBarItemContainerDelegate>

@property (strong, nonatomic) NSMutableArray<FTabBarItemContainer *> *containers;

@end

@implementation FTabBar

- (void)setItems:(NSArray<UITabBarItem *> *)items
{
    [super setItems:items];
    [self setupViews];
}

- (void)setItems:(NSArray<UITabBarItem *> *)items animated:(BOOL)animated
{
    [super setItems:items animated:animated];
    [self setupViews];
}

- (void)setupViews
{
    [self removeViews];
    
    NSArray<UITabBarItem *> *tabBarItems = self.items;
    
    if (!tabBarItems) {
        return;
    }
    
    __weak typeof(self) weakSelf = self;
    [tabBarItems enumerateObjectsUsingBlock:^(UITabBarItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        FTabBarItemContainer *container = [[FTabBarItemContainer alloc] initWithTarget:weakSelf tag:1000 + idx];
        [weakSelf addSubview:container];
        [weakSelf.containers addObject:container];
        
        
    }];
    
    [self setNeedsLayout];
}

- (void)removeViews
{
    for (FTabBarItemContainer *container in self.containers) {
        [container removeFromSuperview];
    }
    [self.containers removeAllObjects];
}

- (NSMutableArray<FTabBarItemContainer *> *)containers
{
    if (!_containers) {
        _containers = [[NSMutableArray alloc] init];
    }
    return _containers;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
