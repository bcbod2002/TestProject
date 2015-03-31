//
//  TestQRCodeViewController.m
//  TestProject
//
//  Created by SSPC139 on 2015/3/4.
//  Copyright (c) 2015年 shinsoft. All rights reserved.
//

#import "TestQRCodeViewController.h"

@interface TestQRCodeViewController ()
{
    AVCaptureSession *captureSession;
}
@end

@implementation TestQRCodeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    captureSession = [[AVCaptureSession alloc] init];
    AVCaptureDevice *cameraCaptureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    NSError *error = nil;
    AVCaptureDeviceInput *videioDeviceInput = [AVCaptureDeviceInput deviceInputWithDevice:cameraCaptureDevice error:&error];
    if (videioDeviceInput)
    {
        [captureSession addInput:videioDeviceInput];
    }
    else
    {
        NSLog(@"Error = %@", error);
    }
    AVCaptureMetadataOutput *metaDataOutput = [[AVCaptureMetadataOutput alloc] init];
    [captureSession addOutput:metaDataOutput];
    [metaDataOutput setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    [metaDataOutput setMetadataObjectTypes:@[AVMetadataObjectTypeQRCode, AVMetadataObjectTypeEAN13Code]];
    AVCaptureVideoPreviewLayer *previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:captureSession];
    [previewLayer setFrame:CGRectMake(0, 0, _qrcodeCameraView.frame.size.width, _qrcodeCameraView.frame.size.height)];
    [_qrcodeCameraView.layer addSublayer:previewLayer];
    [captureSession startRunning];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - AVCaptureMetadataOutoutObjectsDelegate
-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    for (AVMetadataObject *metadaObject in metadataObjects)
    {
        AVMetadataMachineReadableCodeObject *readbleObject = (AVMetadataMachineReadableCodeObject *)metadaObject;
        if ([metadaObject.type isEqualToString:AVMetadataObjectTypeQRCode])
        {
            NSLog(@"QRCode = %@", readbleObject.stringValue);
            [_qrcodeResultLabel setText:readbleObject.stringValue];
        }
        else if ([metadaObject.type isEqualToString:AVMetadataObjectTypeEAN13Code])
        {
            NSLog(@"EAN 13 = %@", readbleObject.stringValue);
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

- (IBAction)startScanButtonAction:(id)sender {
}
@end
