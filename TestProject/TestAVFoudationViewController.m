//
//  TestAVFoudationViewController.m
//  TestProject
//
//  Created by SSPC139 on 2014/10/30.
//  Copyright (c) 2014年 shinsoft. All rights reserved.
//

#import "TestAVFoudationViewController.h"

@interface TestAVFoudationViewController ()
{
    UIImageView *thumbTmpImageView;
    GWHttpMethods *httpMethods;
    NSURL *whatURLm3u8;
}
@end

@implementation TestAVFoudationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"testMpmovie" ofType:@"mp4"];
//    NSURL *urlPath = [NSURL fileURLWithPath:path];
//    NSURL *urlPath = [NSURL URLWithString:@"https://s3-ap-southeast-1.amazonaws.com/mycamstorage/apache/hls/nx0008/000EC903A168/S/8783vs.m3u8"];
//    NSURL *urlPath = [NSURL URLWithString:@"http://stream.alayam.com/alayam/alayam/chunklist_w2018356470.m3u8"];
//    NSURL *urlPath = [NSURL URLWithString:@"http://184.72.239.149/vod/smil:bigbuckbunnyiphone.smil/chunklist-b400000.m3u8"];
//    NSURL *urlPath = [NSURL URLWithString:@"http://video2.lax01.hls.twitch.tv/hls35/neurostarcraft_11832633552_165644754/low/py-index-live.m3u8?token=id=3950141381321204810,bid=11832633552,exp=1416303054,node=video2-1.lax01.hls.justin.tv,nname=video2.lax01,fmt=low&sig=1d3a0e6a2103a7359af70711eb208f0578e869aa"];
    
    //RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR
//    NSURL *urlPath = [NSURL URLWithString:@"http://172.16.40.175:8000/2151657071942527182.m3u8"];
////    NSData *datafromURL = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://video12.lax01.hls.twitch.tv/hls100/tsm_bjergsen_11780210880_164102456/chunked/py-index-live.m3u8?token=id=7754959068739817531,bid=11780210880,exp=1416021030,node=video12-1.lax01.hls.justin.tv,nname=video12.lax01,fmt=chunked&sig=53cb6d34abc167997cf5666157666f1510452666"]];
//    NSString *dataContentString = [[NSString alloc] initWithContentsOfURL:[NSURL URLWithString:@"http://video12.lax01.hls.twitch.tv/hls100/tsm_bjergsen_11780210880_164102456/chunked/py-index-live.m3u8?token=id=7754959068739817531,bid=11780210880,exp=1416021030,node=video12-1.lax01.hls.justin.tv,nname=video12.lax01,fmt=chunked&sig=53cb6d34abc167997cf5666157666f1510452666"] encoding:NSUTF8StringEncoding error:nil];
//    NSLog(@"dataContentString = %@", dataContentString);
//    NSURL *dataContentURL = [NSURL URLWithString:dataContentString];
//    
////    AVAsset *movieAsset = [AVURLAsset URLAssetWithURL:urlPath options:nil];
//    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:urlPath];
//    AVPlayer *player = [AVPlayer playerWithPlayerItem:playerItem];
////    AVPlayer *player = [[AVPlayer alloc] initWithURL:urlPath];
//    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
//    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
//    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
//    playerLayer.frame = CGRectMake(0, screenHeight / 2 - 120, 320, 240);
//    playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
//    [self.view.layer addSublayer:playerLayer];
//    [player play];
      //RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR
    
//    AVPlayerItem *playeritem = [AVPlayerItem playerItemWithURL:urlPath];
//    [playeritem addObserver:self forKeyPath:@"status" options:9 context:nil];
////    UIImageView *thumbnailImageView = [[UIImageView alloc] initWithImage:[self getImage:@"http://184.72.239.149/vod/smil:bigbuckbunnyiphone.smil/chunklist-b400000.m3u8"]];
//    UIImageView *thumbnailImageView = [[UIImageView alloc] initWithImage:[self thumbnailImageForVideo:[NSURL URLWithString:@"http://184.72.239.149/vod/smil:bigbuckbunnyiphone.smil/chunklist-b400000.m3u8"] atTime:30]];
////    UIImageView *thumbnailImageView = [[UIImageView alloc] init];
//    [thumbnailImageView setFrame:CGRectMake(0, 0, 100, 100)];
//    [thumbnailImageView setBackgroundColor:[UIColor blueColor]];
//    [self.view addSubview:thumbnailImageView];
//    
//    
//    AVCaptureSession *myCaptureSession = [[AVCaptureSession alloc] init];
//    [myCaptureSession setSessionPreset:AVCaptureSessionPresetHigh];
//    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
//    AVCaptureDeviceInput *deviceInput = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:nil];
//    if ([myCaptureSession canAddInput:deviceInput])
//    {
//        [myCaptureSession addInput:deviceInput];
//    }
//    AVCaptureVideoDataOutput *dataOutPut = [AVCaptureVideoDataOutput new];
//    dataOutPut.videoSettings = [NSDictionary dictionaryWithObjects:[NSNumber numberWithUnsignedInt:kCVPixelFormatType_420YpCbCr8BiPlanarFullRange] forKeys:(NSString *)kCVPixelBufferPixelFormatTypeKey];
//    if ([myCaptureSession canAddOutput:dataOutPut])
//    {
//        [myCaptureSession addOutput:dataOutPut];
//    }
    
//    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:@"http://stream.alayam.com/alayam/alayam/chunklist_w2018356470.m3u8"]];
//    NSLog(@"playerItem Description = %@", [playerItem description]);
//    NSLog(@"playerItem.debugDescription = %@", playerItem.debugDescription);
//    NSLog(@"playerItem.tracks = %@", playerItem.tracks);
//    NSLog(@"playerItem.timedMetadata = %@", playerItem.timedMetadata);
//    NSLog(@"playerItem.staus = %ld", playerItem.status);
//    NSLog(@"playerItem.extendedLogData = %@", )
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    httpMethods = [[GWHttpMethods alloc] initWithDelegate:self andHttpMethodType:GWHttpMethodGet];

    [_stopButton setEnabled:NO];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(UIImage *)thumbnailImageWithVideoURL:(NSURL *)videoUrl
{
    __block UIImage *thumbImage;
    AVURLAsset *urlAsset = [[AVURLAsset alloc] initWithURL:videoUrl options:nil];
    AVAssetImageGenerator *generator = [[AVAssetImageGenerator alloc] initWithAsset:urlAsset];
    [generator setAppliesPreferredTrackTransform:YES];
    CMTime thumbTime = CMTimeMakeWithSeconds(0, 30);
    AVAssetImageGeneratorCompletionHandler handler = ^(CMTime requestedTime, CGImageRef im, CMTime actualTime, AVAssetImageGeneratorResult result, NSError *error){
        if (result != AVAssetImageGeneratorSucceeded) {
            NSLog(@"couldn't generate thumbnail, error:%@", error);
        }
        //        [button setImage:[UIImage imageWithCGImage:im] forState:UIControlStateNormal];
        //        thumbImg=[[UIImage imageWithCGImage:im] retain];
        //        [generator release];
        NSLog(@"rrr");
        thumbImage = [UIImage imageWithCGImage:im];
        thumbTmpImageView = [[UIImageView alloc] initWithImage:thumbImage];
        NSLog(@"thumbImage = %@", thumbImage);
    };
    CGSize maxSize = CGSizeMake(240, 180);
    [generator setMaximumSize:maxSize];
    [generator generateCGImagesAsynchronouslyForTimes:[NSArray arrayWithObject:[NSValue valueWithCMTime:kCMTimeZero]] completionHandler:handler];
    //    [generator setMaximumSize:CGSizeMake(_previewCollectionView.frame.size.width, _previewCollectionView.frame.size.height)];
    NSLog(@"thumbImageAfter = %@", thumbImage);
    return thumbImage;
}

-(UIImage *)getImage:(NSString *)videoURL
{
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:[NSURL fileURLWithPath:videoURL] options:nil];
    AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    gen.appliesPreferredTrackTransform = YES;
    CMTime time = CMTimeMakeWithSeconds(60, 120);
    NSError *error = nil;
    CMTime actualTime;
    CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    UIImage *thumb = [[UIImage alloc] initWithCGImage:image];
    CGImageRelease(image);
    NSLog(@"RRRR");
    return thumb;
}

- (UIImage*) thumbnailImageForVideo:(NSURL *)videoURL atTime:(NSTimeInterval)time
{
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:videoURL options:nil];
    NSParameterAssert(asset);
    AVAssetImageGenerator *assetImageGenerator = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    assetImageGenerator.appliesPreferredTrackTransform = YES;
    assetImageGenerator.apertureMode = AVAssetImageGeneratorApertureModeEncodedPixels;
    
    CGImageRef thumbnailImageRef = NULL;
    CFTimeInterval thumbnailImageTime = time;
    NSError *thumbnailImageGenerationError = nil;
    thumbnailImageRef = [assetImageGenerator copyCGImageAtTime:CMTimeMake(thumbnailImageTime, 60) actualTime:NULL error:&thumbnailImageGenerationError];
    
    if (!thumbnailImageRef)
        NSLog(@"thumbnailImageGenerationError %@", thumbnailImageGenerationError);
    
    UIImage *thumbnailImage = thumbnailImageRef ? [[UIImage alloc] initWithCGImage:thumbnailImageRef] : nil;
    
    return thumbnailImage;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object
                        change:(NSDictionary *)change context:(void *)context
{
    UIImage *thumbImage;
    if ([keyPath isEqualToString:@"status"]) {
        AVPlayerItem *item = (AVPlayerItem *)object;
        if (item.status == AVPlayerItemStatusReadyToPlay) {
            AVURLAsset *asset = (AVURLAsset *)item.asset;
            AVAssetImageGenerator *imageGenerator = [[AVAssetImageGenerator alloc] initWithAsset:asset];
            CGImageRef thumb = [imageGenerator copyCGImageAtTime:CMTimeMakeWithSeconds(10.0, 1.0)
                                                      actualTime:NULL
                                                           error:NULL];
            thumbImage = [UIImage imageWithCGImage:thumb];
        }
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)avplayerPlayAction:(id)sender
{
//    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:urlPath];
//    AVPlayer *player = [AVPlayer playerWithPlayerItem:playerItem];
//    //    AVPlayer *player = [[AVPlayer alloc] initWithURL:urlPath];
//    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
//    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
//    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
//    playerLayer.frame = CGRectMake(0, screenHeight / 2 - 120, 320, 240);
//    playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
//    [self.view.layer addSublayer:playerLayer];
//    [player play];
    [_ipTextField resignFirstResponder];
    [_portTextField resignFirstResponder];
    [_channelTextField resignFirstResponder];
    [_ismainStreamTextField resignFirstResponder];
    [_startTimeTextField resignFirstResponder];
    [_islocalTextField resignFirstResponder];
    [_maxTextField resignFirstResponder];
    
    [_stopButton setEnabled:YES];
    [_startButton setEnabled:NO];
//    NSURL *playURL = [NSURL URLWithString:[[NSString alloc] initWithFormat:@"http://%@:%@/%@.m3u8", _ipTextField.text, _portTextField.text, _m3u8TextField.text]];
    
//    playURL = [NSURL URLWithString:@"http://wpc.c1a9.edgecastcdn.net/hls-live/20C1A9/bbc_world/ls_satlink/b_,828,528,264,.m3u8"];
    
    NSString *normalGetString = [NSString stringWithFormat:@"http://%@:%@/params/cgi/Camera.QueryLivePlaylists?", _ipTextField.text, _portTextField.text];
    [httpMethods sendHttpGetWithURLString:normalGetString andKeys:@[@"CHANNEL", @"ISMAINSTREAM", @"STARTTIME", @"ISLOCAL", @"MAXMEDIAFILECOUNT"] andValues:@[_channelTextField.text, _ismainStreamTextField.text, _startTimeTextField.text, _islocalTextField.text, _maxTextField.text]];;
//    NSData *whatData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:@"http://172.16.40.203:8000/params/cgi/Camera.QueryLivePlaylists?&CHANNEL=1&ISMAINSTREAM=false&STARTTIME=20141119185100&ISLOCAL=false&MAXMEDIAFILECOUNT=4"]];
//    NSLog(@"whatData = %@", whatData);
//    NSString *stringrrrr = [[NSString alloc] initWithData:whatData encoding:NSUTF8StringEncoding];
//    NSLog(@"stringrrrr = %@", stringrrrr);
//    [_LastURL setText:whatURLm3u8.absoluteString];
//    _testPlayerItem = [AVPlayerItem playerItemWithURL:whatURLm3u8];
//    _testPlayer = [AVPlayer playerWithPlayerItem:_testPlayerItem];
//    _testPlayerLayer = [AVPlayerLayer playerLayerWithPlayer:_testPlayer];
//    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
//    _testPlayerLayer.frame = CGRectMake(0, screenHeight / 2 - 60, 320, 240);
//    _testPlayerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
//    [self.view.layer addSublayer:_testPlayerLayer];
//    [_testPlayer play];
}

- (IBAction)avplayerStopAction:(id)sender
{
    [_ipTextField resignFirstResponder];
    [_portTextField resignFirstResponder];
    [_channelTextField resignFirstResponder];
    [_ismainStreamTextField resignFirstResponder];
    [_startTimeTextField resignFirstResponder];
    [_islocalTextField resignFirstResponder];
    [_maxTextField resignFirstResponder];
    
    [_stopButton setEnabled:NO];
    [_startButton setEnabled:YES];
    [_testPlayer pause];
    _testPlayer = nil;
    _testPlayerItem = nil;
    [_testPlayerLayer removeFromSuperlayer];
    
    _testPlayerLayer = nil;
}

-(void)startPlayYAYA
{
    [_LastURL setText:whatURLm3u8.absoluteString];
    _testPlayerItem = [AVPlayerItem playerItemWithURL:whatURLm3u8];
    _testPlayer = [AVPlayer playerWithPlayerItem:_testPlayerItem];
    _testPlayerLayer = [AVPlayerLayer playerLayerWithPlayer:_testPlayer];
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    _testPlayerLayer.frame = CGRectMake(0, screenHeight / 2 - 10, 320, 240);
    _testPlayerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    [self.view.layer addSublayer:_testPlayerLayer];
    [_testPlayer play];
}

#pragma mark - GWHttpMethods Delegate
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