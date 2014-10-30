//
//  TestAVFoudationViewController.m
//  TestProject
//
//  Created by SSPC139 on 2014/10/30.
//  Copyright (c) 2014年 shinsoft. All rights reserved.
//

#import "TestAVFoudationViewController.h"

@interface TestAVFoudationViewController ()

@end

@implementation TestAVFoudationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSURL *urlPath = [NSURL URLWithString:@"https://s3-ap-southeast-1.amazonaws.com/mycamstorage/_TestFileHLS2_/all.m3u8"];
    AVAsset *movieAsset = [AVURLAsset URLAssetWithURL:urlPath options:nil];
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithAsset:movieAsset];
    AVPlayer *player = [AVPlayer playerWithPlayerItem:playerItem];
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
    playerLayer.frame = self.view.layer.frame;
    playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    [self.view.layer addSublayer:playerLayer];
    [player play];
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
