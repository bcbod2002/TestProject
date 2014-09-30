//
//  PageInitViewController.h
//  TestProject
//
//  Created by shinsoft on 2014/5/7.
//  Copyright (c) 2014年 Goston. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageContentViewController.h"

@interface PageInitViewController : UIViewController<UIPageViewControllerDataSource, UIPageViewControllerDelegate>

@property(nonatomic, strong) UIPageViewController *pageViewController;
@property(nonatomic, strong) PageContentViewController *pageContentViewController;
@property(nonatomic, strong)NSArray *pageSave;

@end
