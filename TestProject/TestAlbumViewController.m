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
    AlbumFullCollectionView *testAlbumView = [[AlbumFullCollectionView alloc] initWithFrame:CGRectMake(0, 200, 320, 240)];
    [self.view addSubview:testAlbumView];
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
