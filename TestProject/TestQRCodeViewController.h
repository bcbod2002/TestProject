//
//  TestQRCodeViewController.h
//  TestProject
//
//  Created by SSPC139 on 2015/3/4.
//  Copyright (c) 2015年 shinsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface TestQRCodeViewController : UIViewController <AVCaptureMetadataOutputObjectsDelegate>

#pragma mark - Storyboard Object
@property (strong, nonatomic) IBOutlet UIView *qrcodeCameraView;
- (IBAction)startScanButtonAction:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *qrcodeResultLabel;


@end
