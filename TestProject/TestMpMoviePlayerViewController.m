//
//  TestMpMoviePlayerViewController.m
//  TestProject
//
//  Created by SSPC139 on 2014/7/29.
//  Copyright (c) 2014年 shinsoft. All rights reserved.
//

#import "TestMpMoviePlayerViewController.h"

@interface TestMpMoviePlayerViewController ()

@end

@implementation TestMpMoviePlayerViewController

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
    NSString *path = [[NSBundle mainBundle] pathForResource:@"testMpmovie" ofType:@"mp4"];
//    NSLog(@"path = %@", path);
    NSURL *urlPath = [NSURL fileURLWithPath:path];
    NSLog(@"urlPath = %@", urlPath);
    
    
    
    _testmoviePlayerController = [[MPMoviePlayerController alloc] initWithContentURL:urlPath];
    [_testmoviePlayerController setScalingMode:MPMovieScalingModeAspectFit];
    [_testmoviePlayerController setRepeatMode:MPMovieRepeatModeNone];
    [_testmoviePlayerController setControlStyle:MPMovieControlStyleNone];
    [_testmoviePlayerController setMovieSourceType:MPMovieSourceTypeFile];
    [_testmoviePlayerController setShouldAutoplay:NO];
    
    float moviewPlayerHeight = 180;
//    [_testmoviePlayerController.view setFrame:CGRectMake(0, (568 / 2) - (moviewPlayerHeight / 2), 320, moviewPlayerHeight)];
    [_testmoviePlayerController.view setFrame:CGRectMake(0, (568 / 2) - 120, 320, 300)];
    
//    [_testmoviePlayerController.view setFrame:CGRectMake(0, 124, 320, 320)];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(movieThumbnailLoadComplete:) name:MPMoviePlayerThumbnailImageRequestDidFinishNotification object:_testmoviePlayerController];
    [_testmoviePlayerController requestThumbnailImagesAtTimes:@[@1.0f] timeOption:MPMovieTimeOptionExact];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackstateNotification:) name:MPMoviePlayerPlaybackStateDidChangeNotification object:_testmoviePlayerController];
    
    [self.view addSubview:_testmoviePlayerController.view];
//    [_testmoviePlayerController stop];
//    [_testmoviePlayerController prepareToPlay];
//    [_testmoviePlayerController stop];
//    [_testmoviePlayerController play];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        sleep(3);
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"WHATTTT???");
            [_testmoviePlayerController setControlStyle:MPMovieControlStyleEmbedded];
        });
    });
}

//-(void)viewDidAppear:(BOOL)animated
//{
//    [super viewDidAppear:animated];
//
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)testUrlCredential
{
    NSURLCredential *credential = [[NSURLCredential alloc] initWithUser:@"admin" password:@"admin" persistence:NSURLCredentialPersistenceForSession];
}

-(void)testProtectionSpace
{
    NSURLProtectionSpace *protectionSpace = [[NSURLProtectionSpace alloc] initWithHost:@"60.251.126.104" port:5015 protocol:@"http" realm:@"mycam.com" authenticationMethod:NSURLAuthenticationMethodDefault];
}

-(void)testURLCredentialStorage
{
    [[NSURLCredentialStorage sharedCredentialStorage] setDefaultCredential:NULL forProtectionSpace:NULL];
}

#pragma mark - NSNotificationCenter
-(void)movieThumbnailLoadComplete:(NSNotification *)receive
{
    [_testmoviePlayerController.view setFrame:CGRectMake(0, (568 / 2) - 120, 320, 300)];
    NSDictionary *receiveInfo = [receive userInfo];
    _tmpImage = [[UIImageView alloc] initWithImage:[receiveInfo valueForKey:MPMoviePlayerThumbnailImageKey]];
    [_tmpImage setFrame:CGRectMake(0, 60, 320, 180)];
    [_testmoviePlayerController.view addSubview:_tmpImage];
}

-(void)playbackstateNotification:(NSNotification *)notification
{
    if (_testmoviePlayerController.playbackState == MPMoviePlaybackStatePlaying)
    {
        NSLog(@"Shit");
        [_tmpImage removeFromSuperview];
    }
//    if (notification == MPMoviePlaybackStatePlaying)
//    {
//        <#statements#>
//    }
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
