//
//  TestMpMoviePlayerViewController.h
//  TestProject
//
//  Created by SSPC139 on 2014/7/29.
//  Copyright (c) 2014年 Goston. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <MediaToolbox/MediaToolbox.h>
#import "GWHttpMethods.h"


@interface TestMpMoviePlayerViewController : UIViewController <GWHttpMethodsDelegate>

@property (nonatomic, strong) MPMoviePlayerController *testmoviePlayerController;
@property (nonatomic, strong) UIImageView *tmpImage;
@property (strong, nonatomic) IBOutlet UITextField *ipTextField;
@property (strong, nonatomic) IBOutlet UITextField *portTextField;
@property (strong, nonatomic) IBOutlet UITextField *channelTextField;
@property (strong, nonatomic) IBOutlet UITextField *ismainStreamTextField;
@property (strong, nonatomic) IBOutlet UITextField *startTimeTextField;
@property (strong, nonatomic) IBOutlet UITextField *islocalTextField;
@property (strong, nonatomic) IBOutlet UITextField *maxTextField;
@property (strong, nonatomic) IBOutlet UIButton *playButton;
@property (strong, nonatomic) IBOutlet UIButton *stopButton;
- (IBAction)playButtonAction:(id)sender;
- (IBAction)stopButtonAction:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *LastURL;

@end
