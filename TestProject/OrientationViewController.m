//
//  OrientationViewController.m
//  TestProject
//
//  Created by SSPC139 on 2014/9/3.
//  Copyright (c) 2014年 Goston. All rights reserved.
//

#import "OrientationViewController.h"

@interface OrientationViewController ()

@end

@implementation OrientationViewController

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
//    PictureManagerView *testPictureManagerView = [[PictureManagerView alloc] initWithFrame:CGRectMake(0, 124, 320, 270)];
    MultiSplitCollectionView *testSplitCollectionView = [[MultiSplitCollectionView alloc] initWithFrame:CGRectMake(0, 100, 320, 240)];
    testSplitCollectionView.delegate = self;
    testSplitCollectionView.previousSplitNumber = FoursplitNumber;
    [self.view addSubview:testSplitCollectionView];
    
}

-(void)splitFlowLayoutChangeFinished
{
    NSLog(@"!!!FFFFF");
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
