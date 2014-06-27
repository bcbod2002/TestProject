//
//  MainViewController.h
//  TestProject
//
//  Created by shinsoft on 2014/3/17.
//  Copyright (c) 2014年 shinsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <pop/POP.h>
#import <QuartzCore/QuartzCore.h>

#import "AppNotificationMessage.h"

@interface MainViewController : UIViewController <UIGestureRecognizerDelegate>

@property (strong, nonatomic) IBOutlet UIProgressView *progressViewTest;
- (IBAction)tableviewAutoLayout:(id)sender;
- (IBAction)dispatchStart:(id)sender;
- (IBAction)dispatchStop:(id)sender;
- (IBAction)dispatchContinue:(id)sender;
- (IBAction)pageViewChange:(id)sender;
- (IBAction)facebookPop:(UIButton *)sender;
- (IBAction)caKeyFrameAnimation:(id)sender;
- (IBAction)appNotificationAnimation:(id)sender;

@property (strong, nonatomic) AppNotificationMessage *appnotificationTest;

@end
