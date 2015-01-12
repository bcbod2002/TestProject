//
//  TestAlbumViewController.m
//  TestProject
//
//  Created by SSPC139 on 2014/12/30.
//  Copyright (c) 2014年 shinsoft. All rights reserved.
//

#import "TestAlbumViewController.h"

@interface TestAlbumViewController ()

@end

@implementation TestAlbumViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGRect screenRect = [UIScreen mainScreen].bounds;
//    AlbumFullCollectionView *testAlbumFullView = [[AlbumFullCollectionView alloc] initWithFrame:CGRectMake(0, 0, screenRect.size.width, screenRect.size.height)];
//    [self.view addSubview:testAlbumFullView];
    
    AlbumNormalCollectionView *testAlbumNormalView = [[AlbumNormalCollectionView alloc] initWithFrame:CGRectMake(0, 0, screenRect.size.width, screenRect.size.height) WithWidthCellNumber:10];
    NSLog(@"Before Add SubView");
    [self.view addSubview:testAlbumNormalView];
    NSLog(@"After Add Subview0");
    NSLog(@"After Add Subview1");
    NSLog(@"After Add Subview2");
    NSLog(@"After Add Subview3");
    NSLog(@"After Add Subview4");
    NSLog(@"After Add Subview5");
    NSLog(@"After Add Subview6");
    NSLog(@"After Add Subview7");
    NSLog(@"After Add Subview8");
    NSLog(@"After Add Subview9");
    
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
