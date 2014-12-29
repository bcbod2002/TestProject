//
//  MainViewController.m
//  TestProject
//
//  Created by shinsoft on 2014/3/17.
//  Copyright (c) 2014年 Goston. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController
{
    NSTimer *timeCounter;
    double progressValue;
    
    UIImageView *backgroundImage;
    CGPoint location;
    
    BOOL* cancelledGlobalQueuePtr;
    NSInteger *continueglobalPtr;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
//    [self progressViewTest];
//    [self createAppNotificationMessage];
    [self CreateMaterialButton];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    progressValue = 0;
//    [self progressBarTest];
//    [self backgroundImageMoveandButtonNotMove];
//    [self webViewTest];
    [self copyTest];
}

#pragma mark - NSArray Test
-(void)testArray
{
    NSArray *testArray;
    testArray = [[NSArray alloc] initWithObjects:@"test", @[@"1", @"2", @"3"], nil];
    if ([testArray containsObject:@[@"1", @"2", @"3"]])
    {
        NSLog(@"12333");
    }
    if ([testArray containsObject:@"test"])
    {
        NSLog(@"werttt");
    }
}

#pragma mark - Image Color
// Goston ADD http://www.cocoachina.com/bbs/read.php?tid=181490\
// http://www.cocoachina.com/bbs/read.php?tid=181492&fpage=13
//背景圖片顏色測試
-(void)imageColorTest
{
    UIImage *testImage = [UIImage imageNamed:@"ImageColor"];
//    NSMutableArray *cls = [[NSMutableArray alloc] init];
    
    //第一步 先把图片缩小 加快计算速度. 但越小结果误差可能越大
    CGSize thumbsize = CGSizeMake(50, 50);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(nil, thumbsize.width, thumbsize.height, 8, thumbsize.width * 4, colorSpace, kCGImageAlphaPremultipliedLast);
    CGRect drawRect = CGRectMake(0, 0, thumbsize.width, thumbsize.height);
    CGContextDrawImage(context, drawRect, testImage.CGImage);
    CGColorSpaceRelease(colorSpace);
    
    
    //第二步 取每个点的像素值
    unsigned char *data = CGBitmapContextGetData(context);
    NSCountedSet *cls = [NSCountedSet setWithCapacity:thumbsize.width * thumbsize.height];

    for (NSInteger x = 0; x < thumbsize.width; ++x)
    {
        for (NSInteger y = 0; y < thumbsize.height; ++y)
        {
            NSInteger offset = 4 * (x * y);
            NSInteger red = data[offset];
            NSInteger green = data[offset + 1];
            NSInteger blue = data[offset + 2];
            NSInteger alpha = data[offset + 3];
            
            NSArray *clr = @[@(red), @(green), @(blue), @(alpha)];
            [cls addObject:clr];
        }
    }
    CGContextRelease(context);
    
    //第三步 找到出现次数最多的那个颜色
    NSEnumerator *enumerator = [cls objectEnumerator];
    NSArray *curColor = nil;
    NSArray *maxColor = nil;
    NSUInteger maxCount = 0;
    while ((curColor = [enumerator nextObject]) != nil)
    {
        NSUInteger tmpcount = [cls count];
        if (tmpcount < maxColor)
        {
            continue;
        }
        maxCount = tmpcount;
        maxColor = curColor;
    }
    UIColor *resultColor = [UIColor colorWithRed:[maxColor[0] intValue] / 255.0f green:[maxColor[1] intValue] / 255.0f blue:[maxColor[2] intValue] / 255.0f alpha:[maxColor[3] intValue] / 255.0f];
    [self.view setBackgroundColor:resultColor];
    [self isLightColor:resultColor];
}

-(void)isLightColor:(UIColor *)clr
{
    CGFloat component[3];
//    [self getRGBComponents:component forColor:clr];
    // getRGBComponents Block Start
    int bitmapinfo = kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedLast;
    CGColorSpaceRef rgbColorSpace = CGColorSpaceCreateDeviceRGB();
    unsigned char resultingPixelp[4];
    CGContextRef context = CGBitmapContextCreate(&resultingPixelp, 1, 1, 8, 4, rgbColorSpace, bitmapinfo);
    CGContextSetFillColorWithColor(context, [clr CGColor]);
    CGContextFillRect(context, CGRectMake(0, 0, 1, 1));
    CGContextRelease(context);
    CGColorSpaceRelease(rgbColorSpace);
    for (NSInteger conponent = 0; conponent < 3; ++conponent)
    {
        component[conponent] = resultingPixelp[conponent];
    }
    // getRGBComponents Block End
    
    NSLog(@"%f  %f  %f", component[0], component[1], component[2]);
    CGFloat num = component[0] + component[1] + component[2];
    if (num < 382)
    {
        NSLog(@"Dark");
    }
    else
    {
        NSLog(@"Light");
    }
}

- (void)getRGBComponents:(CGFloat [3])components forColor:(UIColor *)color
{
    int bitmapinfo = kCGImageAlphaPremultipliedLast;
    CGColorSpaceRef rgbColorSpace = CGColorSpaceCreateDeviceRGB();
    unsigned char resultingPixelp[4];
    CGContextRef context = CGBitmapContextCreate(&resultingPixelp, 1, 1, 8, 4, rgbColorSpace, bitmapinfo);
    CGContextFillRect(context, CGRectMake(0, 0, 1, 1));
    CGContextRelease(context);
    CGColorSpaceRelease(rgbColorSpace);
    for (NSInteger conponent = 0; conponent < 3; ++conponent)
    {
        components[conponent] = resultingPixelp[conponent];
    }
}

#pragma mark - UILabel underLine
-(void) uitextFiledFont
{
    UILabel *testLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 10)];
    [testLabel setText:@"TestUIlabelDecender"];
    CGFloat decender = testLabel.font.descender;
    NSLog(@"%f", decender);
}

#pragma mark - NSLock
-(void) nsLockTest
{
    NSLock *testLock = [[NSLock alloc] init];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [testLock lock];
        [self methodOne];
        sleep(20);
        NSLog(@"Method 1 DONE\n\n");
        [testLock unlock];
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [testLock lock];
        sleep(5);
        [self methodTwo];
        NSLog(@"Method 2 DONE\n\n");
        [testLock unlock];
    });
}

-(void) methodOne
{
    NSLog(@"%@", [NSDate dateWithTimeIntervalSinceNow:5]);
    NSLog(@"Main Thread = %@", [NSThread mainThread]);
    NSLog(@"Method 1\n\n");
}

-(void) methodTwo
{
    NSLog(@"%@", [NSDate dateWithTimeIntervalSinceNow:3]);
    NSLog(@"Main Thread = %@", [NSThread mainThread]);
    NSLog(@"Method 2\n\n");
}

#pragma mark - synchronized
-(void)synchronizedTest
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @synchronized(self)
        {
            [self methodOne];
            sleep(20);
            NSLog(@"Method 1 DONE\n\n");
        }
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(5);
        @synchronized(self)
        {
            
            [self methodTwo];
            
        }
        NSLog(@"Method 2 DONE\n\n");
    });
}

#pragma mark - NSFileManager
-(void)fileManagerTest
{
    NSString *homePath = NSHomeDirectory();
    
    // Document Path
    NSArray *docDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [docDirectory objectAtIndex:0];
    NSLog(@"%@", documentPath);
    // Library Path
    NSArray *libDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
    NSString *libString = [libDirectory objectAtIndex:0];
    
    // Tmp Path
    NSString *tmpPath = NSTemporaryDirectory();
    
    // Cache Path
    NSArray *cacheDirectory = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [cacheDirectory objectAtIndex:0];
    
    // New Folder
    NSString *newFolderPath = [documentPath stringByAppendingPathComponent:@"NewFolder"];
    NSFileManager *filemanagerFolder = [NSFileManager defaultManager];
    if ([filemanagerFolder createDirectoryAtPath:newFolderPath withIntermediateDirectories:YES attributes:nil error:nil])
    {
        NSLog(@"Create New Folder Success????");
    }
    
    // New File
    NSString *newFilePath = [documentPath stringByAppendingPathComponent:@"NewFile.txt"];
    NSFileManager *filemanagerFile = [NSFileManager defaultManager];
    if ([filemanagerFile createFileAtPath:newFilePath contents:nil attributes:nil])
    {
        NSLog(@"Create New File Success!!!!");
    }
    
    // Write Data to File
    NSString *fileContent = @"Test Write content to file";
    if ([fileContent writeToFile:newFilePath atomically:YES encoding:NSUTF8StringEncoding error:nil])
    {
        NSLog(@"Write File Success");
    }
    
    // File Attribute
    NSDictionary *fileAttributes = [filemanagerFile attributesOfItemAtPath:newFilePath error:nil];
    NSLog(@"%@\n", fileAttributes);
}

#pragma mark - NSSearchPathForDirectories
-(void)searchPathForDirectoriesTest
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
    NSString *filename = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"NSSearchPathForDirectories"];
    NSString *fileContent = @"NSSearchPathForDirectoriesTest\n";
    NSData *fileContentData = [fileContent dataUsingEncoding:NSASCIIStringEncoding];
    if ([fileContentData writeToFile:filename options:NSDataWritingAtomic error:nil])
    {
        NSLog(@"File Write Success");
    }
}
#pragma mark - NSKeyedArchiver
-(void)keyedArchiverTest
{
    NSString *saveStrOne = @"I am Data";
    NSString *saveStrTwo = @"Data wert wert";
    
    NSArray *array = [NSArray arrayWithObjects:saveStrOne, saveStrTwo, nil];
    
    // Save Data
    NSArray *savepaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filename = [[savepaths objectAtIndex:0] stringByAppendingPathComponent:@"NSSearchPathForDirectoriesser"];
    [NSKeyedArchiver archiveRootObject:array toFile:filename];
    
    saveStrOne = @"what the";
    saveStrTwo = @"HELL";
    
    array = [NSKeyedUnarchiver unarchiveObjectWithFile:filename];
    saveStrOne = [array objectAtIndex:0];
    saveStrTwo = [array objectAtIndex:1];
    
    NSLog(@"%@", saveStrOne);
    NSLog(@"%@", saveStrTwo);
}

#pragma mark - NSDateComponents
-(void)dateComponentsTest
{
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit;
    components = [calendar components:unitFlags fromDate:now];
    
    NSLog(@"\nYear : %d\nMonth : %d\nDay : %d\nHours : %d\nMinutes : %d\n\n", [components year], [components month], [components day], [components hour], [components minute]);
}

#pragma mark - Operating System Version
-(void)uiDeviceVersion
{
    NSLog(@"%@", [[UIDevice currentDevice] systemVersion]);
    __block NSString *blockString = [[NSString alloc] init];
    
}

#pragma mark - Progress Bar
-(void)progressBarTest
{
    timeCounter = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(progressStart:) userInfo:nil repeats:YES];

    [self.progressViewTest setProgress:0];
}

-(void)progressStart:(NSTimer *)timerCounter
{
    if (progressValue > 10)
    {
        NSLog(@"%@", timerCounter);
        [timeCounter invalidate];
    }
    else
    {
        NSLog(@"progressValue is : %f", progressValue);
        progressValue += 0.01;
        [self.progressViewTest setProgress:progressValue * 0.1 animated:YES];
    }
}

#pragma mark - 背景圖片移動，背景裡按鈕不移動
-(void)backgroundImageMoveandButtonNotMove
{
    backgroundImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 60, 60)];
    [backgroundImage setImage:[UIImage imageNamed:@"ImageColor"]];
    UIButton *backgroundButton = [[UIButton alloc] initWithFrame:CGRectMake(30, 30, 100, 30)];
    [backgroundButton setBackgroundColor:[UIColor whiteColor]];
    [backgroundButton setTitle:@"Background" forState:UIControlStateNormal];
    [backgroundButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    UIGestureRecognizer *moveBackgroundImage = [[UIGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundImageMove:)];
    moveBackgroundImage.delegate = backgroundImage;
    [backgroundButton addGestureRecognizer:moveBackgroundImage];
    [self.view addSubview:backgroundImage];
    [self.view addSubview:backgroundButton];
    
}
-(void)backgroundImageMove:(id)sender
{
    NSLog(@"Touched");
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
//    location = [[touches anyObject] locationInView:backgroundImage];
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint point = [[touches anyObject] locationInView:backgroundImage];
    CGRect frame = backgroundImage.frame;
    CGPoint locate = backgroundImage.frame.origin;
    
    frame.origin.x += (point.x - locate.x);
    frame.origin.y += (point.x - locate.y);
    [backgroundImage setFrame:frame];
}

#pragma mark - UIWebView
-(void)webViewTest
{
    UIWebView *webViewtest = [[UIWebView alloc] initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height)];
    NSString *fullURL = @"http://www.Google.com.tw";
    NSURL *url = [NSURL URLWithString:fullURL];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [self.view addSubview:webViewtest];
    [webViewtest loadRequest:requestObj];
}

#pragma mark - Move to Other UIViewController
- (IBAction)tableviewAutoLayout:(id)sender
{
    [self movetoTableViewController];
}

- (IBAction)pageViewChange:(id)sender
{
    [self movetoPageViewController];
}

- (IBAction)facebookPop:(UIButton *)sender
{
//    POPDecayAnimation *animation = [POPDecayAnimation animationWithPropertyNamed:kPOPLayerPositionX];
//    animation.velocity = @(1000.);
//    [sender.layer pop_addAnimation:animation forKey:@"slide"];
    
    POPBasicAnimation *animation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.fromValue = @(0.0);
    animation.toValue = @(1.0);
    [self.view pop_addAnimation:animation forKey:@"fade"];
}

-(void)movetoTableViewController
{
    UIViewController *tableViewAuto = [self.storyboard instantiateViewControllerWithIdentifier:@"TableViewAutoLayout"];
    [self presentViewController:tableViewAuto animated:YES completion:nil];
}

-(void)movetoPageViewController
{
    UIViewController *pageViewChange = [self.storyboard instantiateViewControllerWithIdentifier:@"pageInitController"];
    [self presentViewController:pageViewChange animated:YES completion:nil];
}

- (IBAction)mpMoviePlayer:(id)sender
{
    UIViewController *mpMoviePlayer = [self.storyboard instantiateViewControllerWithIdentifier:@"moveMpMoviePlayer"];
    [self presentViewController:mpMoviePlayer animated:YES completion:nil];
}


#pragma mark - String Replace
-(void)stringReplaceTest
{
    NSMutableString *str = [NSMutableString stringWithFormat:@"1233333<br>4432111<br>aaaaa"];
    NSRange substr;
    NSLog(@"unReplace : %@\n", str);
    NSString *search = @"<br>";
    NSString *replace = @"\n";
    
    int i = 1;
    while (i == 1)
    {
        substr = [str rangeOfString:search];
        if (substr.location != NSNotFound)
        {
            [str replaceCharactersInRange:substr withString:replace];
            //            [str replaceOccurrencesOfString:search withString:replace options:NSCaseInsensitiveSearch range:substr];
        }
        else
        {
            i = 0;
        }
    }
    NSLog(@"Replaced : %@\n", str);
}

#pragma mark - Copy MutableCopy
-(void)copyTest
{
    NSMutableArray *beCopyArray = [[NSMutableArray alloc] initWithObjects:@"1", @"2", @"3", @"4", @"5", nil];
    NSArray *copyArray = [beCopyArray copy];
    
    NSLog(@"%p", beCopyArray);
    NSLog(@"%p", copyArray);
    NSLog(@"%p", [beCopyArray description]);
    NSLog(@"%p", [copyArray description]);
}

#pragma mark - stop dispatch_get_global_queue
-(void)stopGlobalQueue
{
    
}
- (IBAction)dispatchStart:(id)sender
{
    __block BOOL cancelled = NO;
    __block NSInteger continueInteger = 1;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        while (!cancelled && continueInteger <= 10)
        {
            NSLog(@"Running");
            sleep(1);
            ++continueInteger;
        }
        NSLog(@"stopped");
    });
    cancelledGlobalQueuePtr = &cancelled;
    continueglobalPtr = & continueInteger;
}

- (IBAction)dispatchStop:(id)sender
{
    if (cancelledGlobalQueuePtr)
    {
        NSLog(@"stopping");
        *cancelledGlobalQueuePtr = YES;
    }
}

- (IBAction)dispatchContinue:(id)sender
{
    if (continueglobalPtr)
    {
        NSLog(@"continue");
        *continueglobalPtr = 1;
    }
}

#pragma mark - CAKeyframeAnimation
- (IBAction)caKeyFrameAnimation:(id)sender
{
    [self viewCAKeyframeAnimationTest];
}

- (IBAction)appNotificationAnimation:(id)sender
{
//    [_appnotificationTest perspectiveAppear];
    [_appnotificationTest circleAppear];
//    [_appnotificationTest circleMaskwithOtherMask];
}



-(void)viewCAKeyframeAnimationTest
{
    UIView *testCAKeyFrameView = [[UIView alloc] initWithFrame:CGRectMake(100, 150, 65, 65)];
    [testCAKeyFrameView setBackgroundColor:[UIColor blueColor]];
    [testCAKeyFrameView.layer setCornerRadius:9];
//    [testCAKeyFrameView.layer setBackgroundColor:[[[UIColor blackColor] colorWithAlphaComponent:0.4]  CGColor]];
    [self.view addSubview:testCAKeyFrameView];
    // CAKeyFrameAnimation Start
    CALayer *blacklayer = [CALayer layer];
    blacklayer.backgroundColor = [[[UIColor blackColor] colorWithAlphaComponent:0.4] CGColor];
    [blacklayer setCornerRadius:9];
    [blacklayer setFrame:CGRectMake(0, 0, 65, 65)];
    [testCAKeyFrameView.layer addSublayer:blacklayer];
    
//    CAAnimation *perspactiveAll = []
    
    
    CAKeyframeAnimation *boundsOvershootAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    
    NSValue *nonePerspective = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(0, 0, 0, 0)];
    NSValue *perspectiveOne = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI_4, 0, 1, 0)];
    NSValue *perspectiveTwo = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI_4, 1, 0, 0)];
    NSValue *perspectiveThree = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(-M_PI_4, 1, 0, 0)];
    NSValue *perspectiveFour = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(-M_PI_4, 0, 1, 0)];
    
    //    NSArray *boundsValues = [NSArray arrayWithObjects:[NSValue valueWithCGSize:startungSize], perspective, [NSValue valueWithCGSize:targetSize], [NSValue valueWithCGSize:overShootSize], [NSValue valueWithCGSize:underShootSize], [NSValue valueWithCGSize:targetSize], nil];
    NSArray *boundsValues = [NSArray arrayWithObjects:nonePerspective, perspectiveOne, perspectiveTwo, perspectiveThree, perspectiveFour, nil];
    
    NSArray *times = [NSArray arrayWithObjects:[NSNumber numberWithFloat:0.0], [NSNumber numberWithFloat:0.4], [NSNumber numberWithFloat:0.8], [NSNumber numberWithFloat:1.2], [NSNumber numberWithFloat:1.6], nil];
    
    [boundsOvershootAnimation setKeyTimes:times];
    [boundsOvershootAnimation setValues:boundsValues];
    boundsOvershootAnimation.duration = 2.0;
    boundsOvershootAnimation.removedOnCompletion = NO;
    boundsOvershootAnimation.fillMode = kCAFillModeForwards;
    
    
//    [testCAKeyFrameView.layer addAnimation:boundsOvershootAnimation forKey:@"testOtherAnimation"];
    
    
    CAAnimationGroup *animationAll = [CAAnimationGroup animation];
    animationAll.delegate = self;
    animationAll.removedOnCompletion = NO;
    animationAll.duration = 2;
    animationAll.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animationAll.repeatCount = 4;
    animationAll.fillMode = kCAFillModeForwards;
    animationAll.animations = [NSArray arrayWithObjects:[self perspective3DAllAnimation], [self curveMoveOutanimation], nil];
    
    [testCAKeyFrameView.layer addAnimation:animationAll forKey:@"outttt"];
    
    //    [blacklayer setTransform:transform3d];
    
    // CAKeyFrameAnimation End
    
//    [testCAKeyFrameView removeFromSuperview];
}

-(CAAnimation *)perspective3DAllAnimation
{
    CAKeyframeAnimation *perspectiveAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    CATransform3D transform3Dforword = CATransform3DIdentity;
    transform3Dforword.m34 = -1.0f/200.0f;
    transform3Dforword = CATransform3DRotate(transform3Dforword, M_PI_4, 0, 1, 0);
    
    CATransform3D transform3Dbackword = CATransform3DIdentity;
    transform3Dbackword = CATransform3DRotate(transform3Dforword, -M_PI_4, 0, 1, 0);
    
    
    
    NSValue *nonePerspective = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(0, 0, 0, 0)];
    NSValue *perspectiveforword = [NSValue valueWithCATransform3D:transform3Dforword];
    NSValue *perspectivebackword = [NSValue valueWithCATransform3D:transform3Dbackword];
    
    NSArray *perspectiveValue = [NSArray arrayWithObjects:nonePerspective, perspectiveforword, perspectivebackword, nil];
    NSArray *perspectiveTimeSlide = [NSArray arrayWithObjects:[NSNumber numberWithFloat:0.0], [NSNumber numberWithFloat:0.5], [NSNumber numberWithFloat:1.0], nil];
    
    [perspectiveAnimation setValues:perspectiveValue];
    [perspectiveAnimation setKeyTimes:perspectiveTimeSlide];
    [perspectiveAnimation setDuration:1];
    [perspectiveAnimation setRemovedOnCompletion:NO];
    [perspectiveAnimation setFillMode:kCAFillModeForwards];
    
    return perspectiveAnimation;
}

-(CAAnimation *)curveMoveOutanimation
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    
    animation.duration = 1.0;
    animation.autoreverses = NO;
    animation.removedOnCompletion = NO;
    animation.fromValue = [NSNumber numberWithInt:30];
    animation.toValue = [NSNumber numberWithInt:300];
    animation.delegate = self;
    
    return animation;
}

-(CATransform3D)CATransform3DMakePerspective:(CGPoint)center with:(float)disz
{
    printf("center.x = %f   and  center.y = %f", center.x, center.y);
    CATransform3D transToCenter = CATransform3DMakeTranslation(-center.x, -center.y, 0);
    CATransform3D transBack = CATransform3DMakeTranslation(center.x, center.y, 0);
    CATransform3D scale = CATransform3DIdentity;
    scale.m34 = -1.0f/disz;
//    scale.m34 = 1.0f / disz;
//    scale.m21 = -1.0f/disz;
//    scale.m21 = 1 / disz;
    
    return CATransform3DConcat(CATransform3DConcat(transToCenter, scale), transBack);
}
-(CATransform3D)CATransform3DPerspect:(CATransform3D)t with:(CGPoint)center and:(float)disZ
{
    return CATransform3DConcat(t, [self CATransform3DMakePerspective:center with:disZ]);
}

#pragma mark - AppNotificationMessage
-(void)createAppNotificationMessage
{
    _appnotificationTest = [[AppNotificationMessage alloc] initWithMessageTitle:@"test"];
    [self.view addSubview:_appnotificationTest];
}

#pragma mark - MaterialButton
-(void)CreateMaterialButton
{
    MaterialButton *materialButton = [[MaterialButton alloc] initWithFrame:CGRectMake(20, 370, 160, 40)];
    [materialButton setTitle:@"Material Button" forState:UIControlStateNormal];
    [materialButton setTitleColor:[UIColor colorWithWhite:1 alpha:1] forState:UIControlStateNormal];
    [materialButton setBackgroundColor:[UIColor colorWithRed:29.f / 255.f green:155.f / 255.f blue:1 alpha:1]];
    
    [self.view addSubview:materialButton];
}

#pragma mark - Custom Button View
- (IBAction)testButtonAction:(id)sender
{
    _pushAnimation = [[TestViewControllerTransition alloc] init];
    _interactionController = [[UIPercentDrivenInteractiveTransition alloc] init];

}


-(void)mutableCopyTest
{
    
}
//-(void)viewDidUnload
//{
//    [super viewDidUnload];
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
