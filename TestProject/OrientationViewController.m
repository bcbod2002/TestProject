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
{
    MultiSplitCollectionView *testSplitCollectionView;
}

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

    testSplitCollectionView = [[MultiSplitCollectionView alloc] initWithFrame:CGRectMake(0, 100, 320, 240)];
    testSplitCollectionView.delegate = self;
    testSplitCollectionView.previousSplitNumber = FoursplitNumber;
    [self.view addSubview:testSplitCollectionView];
    
    
    UIView *testGradientView = [[UIView alloc] initWithFrame:CGRectMake(0, 360, 320, 120)];
    [testGradientView setBackgroundColor:[UIColor greenColor]];
    [self.view addSubview:testGradientView];
    
    CAGradientLayer *testGradientLayer = [CAGradientLayer layer];
    [testGradientLayer setFrame:CGRectMake(0, 0, 320, 120)];
    [testGradientLayer setColors:[NSArray arrayWithObjects:(__bridge id)[UIColor whiteColor].CGColor, (__bridge id)[UIColor colorWithWhite:1.0 alpha:0.0f].CGColor, nil]];
    [testGradientLayer setStartPoint:CGPointMake(0, 0)];
    [testGradientLayer setEndPoint:CGPointMake(0, 1)];
    [testGradientView.layer addSublayer:testGradientLayer];
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

- (IBAction)splitOneAction:(id)sender
{
    [testSplitCollectionView changeSplitFlowLayout:OneSplitNumber];
}

- (IBAction)splitFourAction:(id)sender
{
    [testSplitCollectionView changeSplitFlowLayout:FoursplitNumber];
}

- (IBAction)splitNineAction:(id)sender
{
    [testSplitCollectionView changeSplitFlowLayout:NineSplitNumber];
}

- (IBAction)splitSixteenAction:(id)sender
{
    [testSplitCollectionView changeSplitFlowLayout:SixteenSplitNumber];
}

- (IBAction)reloadAction:(id)sender
{
    [testSplitCollectionView setReloadData];
}
@end
