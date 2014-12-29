//
//  TestAVFoudationViewController.h
//  TestProject
//
//  Created by SSPC139 on 2014/10/30.
//  Copyright (c) 2014年 shinsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "GWHttpMethods.h"

@interface TestAVFoudationViewController : UIViewController <GWHttpMethodsDelegate>
- (IBAction)avplayerPlayAction:(id)sender;
- (IBAction)avplayerStopAction:(id)sender;

@property (strong, nonatomic) IBOutlet UITextField *ipTextField;
@property (strong, nonatomic) IBOutlet UITextField *portTextField;
@property (strong, nonatomic) IBOutlet UITextField *channelTextField;
@property (strong, nonatomic) IBOutlet UITextField *ismainStreamTextField;
@property (strong, nonatomic) IBOutlet UITextField *startTimeTextField;
@property (strong, nonatomic) IBOutlet UITextField *islocalTextField;
@property (strong, nonatomic) IBOutlet UITextField *maxTextField;
@property (strong, nonatomic) IBOutlet UILabel *LastURL;

@property (strong, nonatomic) IBOutlet UIButton *startButton;
@property (strong, nonatomic) IBOutlet UIButton *stopButton;

@property (strong, nonatomic) AVPlayerItem *testPlayerItem;
@property (strong, nonatomic) AVPlayer *testPlayer;
@property (strong, nonatomic) AVPlayerLayer *testPlayerLayer;



@end
