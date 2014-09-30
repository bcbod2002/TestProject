//
//  PageInitViewController.m
//  TestProject
//
//  Created by shinsoft on 2014/5/7.
//  Copyright (c) 2014年 Goston. All rights reserved.
//

#import "PageInitViewController.h"


@interface PageInitViewController ()

@end

@implementation PageInitViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"pageViewController"];
    _pageViewController.delegate = self;
    _pageViewController.dataSource = self;

    
    PageContentViewController *startViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startViewController];
    [_pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    _pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 30);
    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];
    [_pageViewController didMoveToParentViewController:self];
}

-(PageContentViewController *)viewControllerAtIndex:(NSUInteger)index
{
    PageContentViewController *pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"pageContentViewController"];
    pageContentViewController.pageIndex = index;
    return pageContentViewController;
}

#pragma mark - PageViewController
//-(void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
//{
//    
//}

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = ((PageContentViewController *)viewController).pageIndex;
    
    if (index == 0 || index == NSNotFound)
    {
        return nil;
    }
    index--;
    NSLog(@"index = %lu", (unsigned long)index);
    return [self viewControllerAtIndex:index];
}

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    
    NSUInteger index = ((PageContentViewController *) viewController).pageIndex;
    
    if (index == 1 || index == NSNotFound)
    {
        return nil;
    }
    index++;
    NSLog(@"index = %lu", (unsigned long)index);
    return [self viewControllerAtIndex:1];
}


//-(NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
//{
//}

-(NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
