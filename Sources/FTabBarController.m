//
//  FTabBarController.m
//  FTabBarController
//
//  Created by Fmyz on 2017/6/12.
//  Copyright © 2017年 Fmyz. All rights reserved.
//

#import "FTabBarController.h"
#import "FTabBar.h"

@interface FTabBarController ()

@end

@implementation FTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    FTabBar *ftb = [[FTabBar alloc] init];
    ftb.delegate = self;
    [self setValue:ftb forKey:@"tabBar"];
    
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


@implementation FTabBarController (MutableViewControllers)

- (void)addViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (!viewController) {
        return;
    }
    NSMutableArray<UIViewController *> *mutableViewControllers = [self mutableViewControllers];
    if (!mutableViewControllers) {
        return;
    }
    [mutableViewControllers addObject:viewController];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self setViewControllers:[mutableViewControllers copy] animated:animated];
    });
}

- (void)insertViewController:(UIViewController *)viewController atIndex:(NSInteger)index animated:(BOOL)animated
{
    if (!viewController) {
        return;
    }
    NSMutableArray<UIViewController *> *mutableViewControllers = [self mutableViewControllers];
    if (!mutableViewControllers) {
        return;
    }
    index = MIN(index, mutableViewControllers.count - 1);
    [mutableViewControllers insertObject:viewController atIndex:index];
        
    dispatch_async(dispatch_get_main_queue(), ^{
        [self setViewControllers:[mutableViewControllers copy] animated:animated];
    });
}

- (void)removeViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (!viewController) {
        return;
    }
    NSMutableArray<UIViewController *> *mutableViewControllers = [self mutableViewControllers];
    if (!mutableViewControllers || ![mutableViewControllers containsObject:viewController]) {
        return;
    }
    [mutableViewControllers removeObject:viewController];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self setViewControllers:[mutableViewControllers copy] animated:animated];
    });
}

- (void)removeViewControllerAtIndex:(NSInteger)index animated:(BOOL)animated
{
    NSMutableArray<UIViewController *> *mutableViewControllers = [self mutableViewControllers];
    if (!mutableViewControllers) {
        return;
    }
    index = MIN(index, mutableViewControllers.count - 1);
    [mutableViewControllers removeObjectAtIndex:index];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self setViewControllers:[mutableViewControllers copy] animated:animated];
    });
}

- (NSMutableArray<UIViewController *> *)mutableViewControllers
{
    if (!self.viewControllers || self.viewControllers.count == 0) {
        return nil;
    }
    NSMutableArray<UIViewController *> *mutableViewControllers = [NSMutableArray arrayWithArray:self.viewControllers];
    return mutableViewControllers;
}

@end
