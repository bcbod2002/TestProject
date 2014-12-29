//
//  TestMpMoviePlayerViewController.m
//  TestProject
//
//  Created by SSPC139 on 2014/7/29.
//  Copyright (c) 2014年 Goston. All rights reserved.
//

#import "TestMpMoviePlayerViewController.h"

@interface TestMpMoviePlayerViewController ()
{
    GWHttpMethods *httpMethods;
    NSURL *whatURLm3u8;
}
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
    
      //RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR
    NSString *path = [[NSBundle mainBundle] pathForResource:@"testMpmovie" ofType:@"mp4"];
    
//    NSLog(@"path = %@", path);
    NSURL *urlPath = [NSURL fileURLWithPath:path];
//    NSURL *urlPath = [NSURL URLWithString:@"http://172.16.40.175:8000/2337962082971719558.m3u8"];
////    NSURL *urlPath = [NSURL URLWithString:@"http://video11.lax01.hls.twitch.tv/hls72/colminigun_11857020528_166355340/low/py-index-live.m3u8?token=id=7350810893158258371,bid=11857020528,exp=1416454773,node=video11-1.lax01.hls.justin.tv,nname=video11.lax01,fmt=low&sig=59d6c81257fc57b488797b49d39e8fd895b9f896"];
////    NSURL *urlPath = [NSURL URLWithString:@"http://184.72.239.149/vod/smil:bigbuckbunnyiphone.smil/chunklist-b400000.m3u8"];
////    NSURL *urlPath = [NSURL URLWithString:@"http://172.16.40.203:8000/TestHLS.m3u8"];
//    NSLog(@"urlPath = %@", urlPath);
//    
//    
//    
    _testmoviePlayerController = [[MPMoviePlayerController alloc] initWithContentURL:urlPath];
    [_testmoviePlayerController prepareToPlay];
    [_testmoviePlayerController setScalingMode:MPMovieScalingModeFill];
    [_testmoviePlayerController setRepeatMode:MPMovieRepeatModeNone];
    [_testmoviePlayerController setControlStyle:MPMovieControlStyleEmbedded];
    [_testmoviePlayerController setMovieSourceType:MPMovieSourceTypeStreaming];
    [_testmoviePlayerController setShouldAutoplay:YES];
//
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(movieLoadChnge:) name:MPMoviePlayerLoadStateDidChangeNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayBackDidFinish:) name:MPMoviePlayerPlaybackStateDidChangeNotification object:nil];
//    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        for (NSInteger i = 0; i < 10; ++i)
//        {
//            [NSThread sleepForTimeInterval:10];
//            dispatch_async(dispatch_get_main_queue(), ^{
//                NSLog(@"time metaData timestamp = %f", [_testmoviePlayerController.timedMetadata[0] timestamp]);
//                NSLog(@"_testmoviePlayerController loadState = %lu", [_testmoviePlayerController loadState]);
//                NSLog(@"playback State = %lu", [_testmoviePlayerController playbackState]);
//                NSLog(@"playback duration = %f", [_testmoviePlayerController playableDuration]);
//                NSLog(@"movieplayer error log = %@", [[_testmoviePlayerController errorLog] events]);
//                NSLog(@"play accessLog = %@", [[_testmoviePlayerController accessLog] events]);
//                NSLog(@" play current Time = %f", [_testmoviePlayerController currentPlaybackTime]);
//            });
//        }
//    });
//    
//    
//      //RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR
//    float moviewPlayerHeight = 180;
////    [_testmoviePlayerController.view setFrame:CGRectMake(0, (568 / 2) - (moviewPlayerHeight / 2), 320, moviewPlayerHeight)];
//    [_testmoviePlayerController.view setFrame:CGRectMake(0, (568 / 2) - 120, 320, 300)];
//    [_testmoviePlayerController.view setBackgroundColor:[UIColor redColor]];
//    
////    [_testmoviePlayerController.view setFrame:CGRectMake(0, 124, 320, 320)];
////    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(movieThumbnailLoadComplete:) name:MPMoviePlayerThumbnailImageRequestDidFinishNotification object:_testmoviePlayerController];
////    [_testmoviePlayerController requestThumbnailImagesAtTimes:@[@1.0f] timeOption:MPMovieTimeOptionExact];
//    
////    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackstateNotification:) name:MPMoviePlayerPlaybackStateDidChangeNotification object:_testmoviePlayerController];
//    
//    [self.view addSubview:_testmoviePlayerController.view];
////    [_testmoviePlayerController stop];
////    [_testmoviePlayerController prepareToPlay];
////    [_testmoviePlayerController stop];
////    [_testmoviePlayerController play];
////    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
////        sleep(3);
////        dispatch_async(dispatch_get_main_queue(), ^{
////            NSLog(@"WHATTTT???");
////            [_testmoviePlayerController setControlStyle:MPMovieControlStyleEmbedded];
////        });
////    });
//    
//    [_testmoviePlayerController play];
      //RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    httpMethods = [[GWHttpMethods alloc] initWithDelegate:self andHttpMethodType:GWHttpMethodGet];
    [_stopButton setEnabled:NO];
    
//    _testmoviePlayerController = [[MPMoviePlayerController alloc] init];
//    [_testmoviePlayerController setScalingMode:MPMovieScalingModeFill];
//    [_testmoviePlayerController setRepeatMode:MPMovieRepeatModeNone];
//    [_testmoviePlayerController setControlStyle:MPMovieControlStyleEmbedded];
//    [_testmoviePlayerController setMovieSourceType:MPMovieSourceTypeStreaming];
//    [_testmoviePlayerController.view setFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height / 2 - 10, 320, 240)];
//    [self.view addSubview:_testmoviePlayerController.view];
    
}

//-(void)viewDidAppear:(BOOL)animated
//{
//    [super viewDidAppear:animated];
//
//}

- (void) moviePlayBackDidFinish:(NSNotification*)notification
{
    NSLog(@"playback state change  [notification userInfo] = %@", [notification userInfo]);
//    NSError *error = [[notification userInfo] objectForKey:@"error"];
//    if (error) {
//        NSLog(@"Did finish with error: %@", error);
//    }
}

- (void) movieLoadChnge:(NSNotification *)notification
{
    NSLog(@"load state change [notification userInfo] = %@", [notification userInfo]);
}

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

- (IBAction)playButtonAction:(id)sender
{
    [_ipTextField resignFirstResponder];
    [_portTextField resignFirstResponder];
    [_channelTextField resignFirstResponder];
    [_ismainStreamTextField resignFirstResponder];
    [_startTimeTextField resignFirstResponder];
    [_islocalTextField resignFirstResponder];
    [_maxTextField resignFirstResponder];
    
    [_stopButton setEnabled:YES];
    [_playButton setEnabled:NO];
    NSString *normalGetString = [NSString stringWithFormat:@"http://%@:%@/params/cgi/Camera.QueryLivePlaylists?", _ipTextField.text, _portTextField.text];
    [httpMethods sendHttpGetWithURLString:normalGetString andKeys:@[@"CHANNEL", @"ISMAINSTREAM", @"STARTTIME", @"ISLOCAL", @"MAXMEDIAFILECOUNT"] andValues:@[_channelTextField.text, _ismainStreamTextField.text, _startTimeTextField.text, _islocalTextField.text, _maxTextField.text]];;
//    playURL = [NSURL URLWithString:@"http://wpc.c1a9.edgecastcdn.net/hls-live/20C1A9/bbc_world/ls_satlink/b_,828,528,264,.m3u8"];
//    [_LastURL setText:whatURLm3u8.absoluteString];
//    [_testmoviePlayerController setContentURL:whatURLm3u8];
//    [_testmoviePlayerController play];
}

- (IBAction)stopButtonAction:(id)sender
{
    [_ipTextField resignFirstResponder];
    [_portTextField resignFirstResponder];
    [_channelTextField resignFirstResponder];
    [_ismainStreamTextField resignFirstResponder];
    [_startTimeTextField resignFirstResponder];
    [_islocalTextField resignFirstResponder];
    [_maxTextField resignFirstResponder];
    
    [_stopButton setEnabled:NO];
    [_playButton setEnabled:YES];
    
    [_testmoviePlayerController stop];
}

-(void) startPlayYAYA
{
    [_LastURL setText:whatURLm3u8.absoluteString];
    [_testmoviePlayerController setContentURL:whatURLm3u8];
    [_testmoviePlayerController play];
}

-(void)getResult:(GWHttpMethods *)connect result:(NSData *)data
{
    NSString *whatDamnString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    whatDamnString = [whatDamnString stringByReplacingOccurrencesOfString:@"<HTML><BODY>" withString:@""];
    whatDamnString = [whatDamnString stringByReplacingOccurrencesOfString:@"<BR></BODY></HTML>" withString:@""];
    NSLog(@"whatDamnString = %@", whatDamnString);
    whatURLm3u8 = [NSURL URLWithString:whatDamnString];
    if (whatURLm3u8 != nil)
    {
        [self startPlayYAYA];
    }
}
@end
