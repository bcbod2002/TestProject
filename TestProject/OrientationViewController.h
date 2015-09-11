//
//  OrientationViewController.h
//  TestProject
//
//  Created by SSPC139 on 2014/9/3.
//  Copyright (c) 2014年 Goston. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MultiSplitCollectionView.h"
#import "FourSplitFlowLayout.h"

@interface OrientationViewController : UIViewController <MultiSplitCollectionViewDelegate>
- (IBAction)splitOneAction:(id)sender;
- (IBAction)splitFourAction:(id)sender;
- (IBAction)splitNineAction:(id)sender;
- (IBAction)splitSixteenAction:(id)sender;

- (IBAction)reloadAction:(id)sender;

@end
