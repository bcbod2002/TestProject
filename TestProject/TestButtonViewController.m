//
//  TestButtonViewController.m
//  TestProject
//
//  Created by SSPC139 on 2014/12/5.
//  Copyright (c) 2014年 shinsoft. All rights reserved.
//

#import "TestButtonViewController.h"

@interface TestButtonViewController ()

@end

@implementation TestButtonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    TestButton *tmpButton = [[TestButton alloc] initWithFrame:_tempView.frame];
    [_tempView addSubview:tmpButton];
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
