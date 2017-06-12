//
//  ESTabBarController.m
//  ContactsA
//
//  Created by Fmyz on 2017/6/5.
//  Copyright © 2017年 Fmyz. All rights reserved.
//

#import "ESTabBarController.h"

@interface ESTabBarController () 

@property (assign, nonatomic) BOOL ignoreNextSelection;

@end

@implementation ESTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    ESTabBar *tabBar = [[ESTabBar alloc] init];
    tabBar.delegate = self;
    tabBar.customDelegate = self;
    tabBar.tabBarController = self;
    [self setValue:tabBar forKey:@"tabBar"];
}

- (void)setSelectedViewController:(__kindof UIViewController *)selectedViewController
{
    if (!selectedViewController) {
        return;
    }
    
    if (_ignoreNextSelection) {
        _ignoreNextSelection = NO;
        return;
    }
    
    UITabBar *tabBar = self.tabBar;
    if (!tabBar || ![tabBar isKindOfClass:[ESTabBar class]]) {
        return;
    }
    
    NSArray *items = tabBar.items;
    NSInteger index = [self.viewControllers indexOfObject:selectedViewController];
    if (!items || index == NSNotFound) {
        return;
    }

    NSInteger value = ([ESTabBarController isShowingMore:self] && index > items.count - 1) ? items.count - 1 : index;
    [(ESTabBar *)tabBar selectWithItemAtIndex:value animated:NO];
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex
{
    if (_ignoreNextSelection) {
        _ignoreNextSelection = NO;
        return;
    }
    
    UITabBar *tabBar = self.tabBar;
    NSArray *items = tabBar.items;
    
    if (!tabBar || ![tabBar isKindOfClass:[ESTabBar class]] || !items) {
        return;
    }
    
    NSInteger value = ([ESTabBarController isShowingMore:self] && selectedIndex > items.count - 1) ? items.count - 1 : selectedIndex;
    [(ESTabBar *)tabBar selectWithItemAtIndex:value animated:NO];
}

#pragma mark- UITabBarDelegate
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    if (!tabBar.items) {
        return;
    }
    NSInteger idx = [tabBar.items indexOfObject:item];
    if (idx == NSNotFound) {
        return;
    }
    
    if (idx == tabBar.items.count - 1 && [ESTabBarController isShowingMore:self]) {
        _ignoreNextSelection = YES;
        self.selectedViewController = self.moreNavigationController;
        return;
    }
    
    UIViewController *vc = [self.viewControllers objectAtIndex:idx];
    if (vc) {
        _ignoreNextSelection = YES;
        self.selectedIndex = idx;
        if (self.delegate) {
            [self.delegate tabBarController:self didSelectViewController:vc];
        }
    }
}

- (void)tabBar:(UITabBar *)tabBar willBeginCustomizingItems:(NSArray<UITabBarItem *> *)items
{
    if (tabBar && [tabBar isKindOfClass:[ESTabBar class]]) {
        [(ESTabBar *)tabBar updateLayout];
    }
}

- (void)tabBar:(UITabBar *)tabBar didEndCustomizingItems:(NSArray<UITabBarItem *> *)items changed:(BOOL)changed
{
    if (tabBar && [tabBar isKindOfClass:[ESTabBar class]]) {
        [(ESTabBar *)tabBar updateLayout];
    }
}

#pragma mark- ESTabBarDelegate
- (BOOL)tabBar:(UITabBar *)tabBar shouldSelectItem:(UITabBarItem *)item
{
    NSLog(@"tabBar.items.count:%lu", tabBar.items.count);
    NSInteger idx = [tabBar.items indexOfObject:item];
    if (idx == NSNotFound) {
        return NO;
    }
    UIViewController *vc = [self.viewControllers objectAtIndex:idx];
    if (vc) {
        
        if (self.delegate) {
            return [self.delegate tabBarController:self shouldSelectViewController:vc];
        }
    }
    
    return YES;
}

- (BOOL)tabBar:(UITabBar *)tabBar shouldHijackItem:(UITabBarItem *)item
{
    NSInteger idx = [tabBar.items indexOfObject:item];
    if (idx == NSNotFound) {
        return NO;
    }
    UIViewController *vc = [self.viewControllers objectAtIndex:idx];
    if (vc) {
        if (self.shouldHijackHandler) {
            return self.shouldHijackHandler(self, vc, idx);
        }
    }
    return NO;
}

- (void)tabBar:(UITabBar *)tabBar didHijackItem:(UITabBarItem *)item
{
    NSInteger idx = [tabBar.items indexOfObject:item];
    if (idx == NSNotFound) {
        return;
    }
    UIViewController *vc = [self.viewControllers objectAtIndex:idx];
    if (vc) {
        if (self.didHijackHandler) {
            return self.didHijackHandler(self, vc, idx);
        }
    }
}

+ (BOOL)isShowingMore:(UITabBarController *)tabBarController
{
    if (!tabBarController) {
        return NO;
    }
    if (!tabBarController.moreNavigationController) {
        return NO;
    }
    return tabBarController.moreNavigationController.parentViewController != nil;
}

+ (void)printError:(NSString *)description
{
#if DEBUG
    NSLog(@"ERROR: ESTabBarController catch an error %@", description);
#endif
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
