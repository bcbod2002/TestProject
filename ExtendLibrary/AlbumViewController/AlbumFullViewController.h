//
//  AlbumFullViewController.h
//  EasyCam
//
//  Created by SSPC139 on 2014/12/10.
//  Copyright (c) 2014年 shinsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PopOutView.h"
#import "Utility.h"

@interface AlbumFullViewController : UIViewController <UIScrollViewAccessibilityDelegate, UIScrollViewDelegate, UIAlertViewDelegate, UIGestureRecognizerDelegate, PopOutViewDelegate>
@property (strong, nonatomic) IBOutlet UIScrollView *scrollViewFull;
@property (strong, nonatomic) NSMutableArray *pictureNamesArray;
@property (nonatomic) NSInteger selectedPictureNumber;

@end
