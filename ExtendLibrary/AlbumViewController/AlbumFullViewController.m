//
//  AlbumFullViewController.m
//  EasyCam
//
//  Created by SSPC139 on 2014/9/24.
//  Copyright (c) 2014年 shinsoft. All rights reserved.
//

#import "AlbumFullViewController.h"

@interface AlbumFullViewController ()

@end

@implementation AlbumFullViewController
{
    UILabel *pictureDateLabel;
    UILabel *pictureTimeLabel;
    //    NSInteger scrollViewPageNumber;
    NSMutableArray *picturesImageArray;
    NSMutableArray *scrollViewsZoomArray;
    PopOutView *deletePictureView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //------------------------
    picturesImageArray = [[NSMutableArray alloc] init];
    scrollViewsZoomArray = [[NSMutableArray alloc] init];
    
    // Do any additional setup after loading the view.
    
    float navigationBarCenterX = self.navigationController.navigationBar.frame.size.width / 2;
    float navigationBarCenterY = self.navigationController.navigationBar.frame.size.height / 2;
    pictureDateLabel = [[UILabel alloc] initWithFrame:CGRectMake(navigationBarCenterX - 75, navigationBarCenterY - 20, 150, 20)];
    [pictureDateLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:12]];
    [pictureDateLabel setTextColor:[UIColor colorWithWhite:1.f alpha:0.7f]];
    [pictureDateLabel setNumberOfLines:0];
    [pictureDateLabel setTextAlignment:NSTextAlignmentCenter];
    
    pictureTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(navigationBarCenterX - 75, navigationBarCenterY, 150, 20)];
    [pictureTimeLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:10]];
    [pictureTimeLabel setTextColor:[UIColor colorWithWhite:1.f alpha:0.7f]];
    [pictureTimeLabel setNumberOfLines:0];
    [pictureTimeLabel setTextAlignment:NSTextAlignmentCenter];
    
    // Add TrashButton on UINavigationBar
    UIBarButtonItem *trashButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(deleteCurrentPagePhoto:)];
    self.navigationItem.rightBarButtonItem = trashButton;
    
    // Add Tap Gesture Hide NabigationBar
    UITapGestureRecognizer *tapGestureHideBar = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapUIScrollViewHideBar:)];
    [tapGestureHideBar setNumberOfTouchesRequired:1];
    [tapGestureHideBar setNumberOfTapsRequired:1];
    //    [self.view addGestureRecognizer:tapGestureHideBar];
    [_scrollViewFull addGestureRecognizer:tapGestureHideBar];
    
    
    // Test
    deletePictureView = [[PopOutView alloc] initWithDeleget:self];
    [self.view addSubview:deletePictureView];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //    [self.navigationController setNavigationBarHidden:NO];
    [self.navigationController.navigationBar setBackgroundColor:[UIColor colorWithRed:48.f / 255.f green:48.f / 255.f blue:48.f / 255.f alpha:0.7f]];
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithWhite:1.f alpha:0.7f]];
    //-------------------------------------------
    NSArray *pictureDatTimeLabelTextArray = [self pictureTitleStringSeparatedWithSelectedNumber:_selectedPictureNumber];
    [pictureDateLabel setText:[pictureDatTimeLabelTextArray objectAtIndex:0]];
    [pictureTimeLabel setText:[pictureDatTimeLabelTextArray objectAtIndex:1]];
    [self.navigationController.navigationBar addSubview:pictureDateLabel];
    [self.navigationController.navigationBar addSubview:pictureTimeLabel];
    
    
    
    // Screen Size
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    // Navigation Bar Size
    CGSize navigationBarSize = self.navigationController.navigationBar.frame.size;
    // Tab Bar Size
    CGSize tabBarSize = self.tabBarController.tabBar.frame.size;
    // Status Bar Size
    CGSize statusBarSize = [UIApplication sharedApplication].statusBarFrame.size;
    
    
    for (NSInteger i = 0; i < _pictureNamesArray.count; ++i)
    {
        // Add Tap Twice Gesture
        UITapGestureRecognizer *tapTwiceGestureZoomIn = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTwiceScrollViewZoomIn:)];
        [tapTwiceGestureZoomIn setNumberOfTouchesRequired:1];
        [tapTwiceGestureZoomIn setNumberOfTapsRequired:2];
        
        UIScrollView *pictureScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(i * _scrollViewFull.frame.size.width, 0, _scrollViewFull.frame.size.width, _scrollViewFull.frame.size.height)];
        [pictureScrollView setDelegate:self];
        [pictureScrollView setShowsHorizontalScrollIndicator:NO];
        [pictureScrollView setShowsVerticalScrollIndicator:NO];
        [pictureScrollView setMaximumZoomScale:3.f];
        [pictureScrollView setMinimumZoomScale:1.f];
        [pictureScrollView setContentSize:screenSize];
        [pictureScrollView setTag:1];
        
        
        UIImageView *pictureImageView = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:[Utility getDocumentFilePath:_pictureNamesArray[i] withType:@"IMG"]]];
        [pictureImageView setFrame:CGRectMake(0, (screenSize.height - (statusBarSize.height + navigationBarSize.height + tabBarSize.height)) / 2 - (statusBarSize.height + navigationBarSize.height), screenSize.width, (screenSize.width * 3 / 4))];
        
        [pictureScrollView addSubview:pictureImageView];
        [pictureScrollView addGestureRecognizer:tapTwiceGestureZoomIn];
        
        [picturesImageArray addObject:pictureImageView];
        [scrollViewsZoomArray addObject:pictureScrollView];
        [_scrollViewFull addSubview:pictureScrollView];
    }
    
    [_scrollViewFull setContentOffset:CGPointMake(screenSize.width * _selectedPictureNumber, 0)];
    [_scrollViewFull setContentSize:CGSizeMake(_scrollViewFull.frame.size.width * _pictureNamesArray.count, _scrollViewFull.frame.size.height)];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [pictureDateLabel removeFromSuperview];
    [pictureTimeLabel removeFromSuperview];
    
    for (UIImageView *pictureImage in picturesImageArray)
    {
        [pictureImage removeFromSuperview];
    }
    for (UIScrollView *scrollView in scrollViewsZoomArray)
    {
        [scrollView removeFromSuperview];
    }
    [picturesImageArray removeAllObjects];
    [scrollViewsZoomArray removeAllObjects];
//    [self.navigationController popToRootViewControllerAnimated:NO];
//    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - StringSeparated
-(NSArray *)pictureTitleStringSeparatedWithSelectedNumber:(NSInteger)number
{
//    NSLog(@"pictureTitleStringSeparatedWithSelectedNumber  number = %d", number);
    NSArray *titleSeparatedArray = [[_pictureNamesArray objectAtIndex:number] componentsSeparatedByString:@"_"];
    NSString *dateString = [titleSeparatedArray objectAtIndex:0];
    NSString *timeString = [[titleSeparatedArray objectAtIndex:1] substringToIndex:[[titleSeparatedArray objectAtIndex:1] length] - 4];
    
    NSDateFormatter *oldDateFormatter = [[NSDateFormatter alloc] init];
    NSDateFormatter *newDateFormatter = [[NSDateFormatter alloc] init];
    [oldDateFormatter setDateFormat:@"yyyyMMdd"];
    [newDateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [oldDateFormatter dateFromString:dateString];
    
    NSDateFormatter *oldTimeFormatter = [[NSDateFormatter alloc] init];
    NSDateFormatter *newTimeFormatter = [[NSDateFormatter alloc] init];
    [oldTimeFormatter setDateFormat:@"HHmmssSS"];
    [newTimeFormatter setDateFormat:@"HH:mm:SS"];
    NSDate *time = [oldTimeFormatter dateFromString:timeString];
    
    NSString *lastDateString = [NSString stringWithFormat:@"%@ : %@", NSLocalizedStringFromTable(@"DATE", @"Localizable", nil), [newDateFormatter stringFromDate:date]];
    NSString *lastTimeString = [NSString stringWithFormat:@"%@ : %@", NSLocalizedStringFromTable(@"TIME", @"Localizable", nil), [newTimeFormatter stringFromDate:time]];
    
    return @[lastDateString, lastTimeString];
}

#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.tag == 0)
    {
        _selectedPictureNumber = scrollView.contentOffset.x / 320;
//        NSLog(@"_selectedPictureNumber = %d", _selectedPictureNumber);
        NSArray *separatedTitleArray = [self pictureTitleStringSeparatedWithSelectedNumber:_selectedPictureNumber];
        
        [pictureDateLabel setText:separatedTitleArray[0]];
        [pictureTimeLabel setText:separatedTitleArray[1]];
    }
    
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return [picturesImageArray objectAtIndex:_selectedPictureNumber];
}

-(void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    picturesImageArray[_selectedPictureNumber] = [self adjustCenterScrollView:scrollView withContentsView:[picturesImageArray objectAtIndex:_selectedPictureNumber]];
}

// Adjust ScrollView Content View
- (UIView *)adjustCenterScrollView:(UIScrollView *)scrollView withContentsView:(UIView *)view
{
    CGSize boundsSize = scrollView.bounds.size;
    CGSize statusBarSize = [UIApplication sharedApplication].statusBarFrame.size;
    CGSize navigationBarSize = self.navigationController.navigationBar.frame.size;
    CGRect contentsFrame = view.frame;
    
    if (contentsFrame.size.width < boundsSize.width)
    {
        contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) / 2.0f;
    }
    else
    {
        contentsFrame.origin.x = 0.0f;
    }
    if (contentsFrame.size.height < boundsSize.height)
    {
        if ([UIScreen mainScreen].bounds.size.height >= 568)
        {
            contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) / 2.0f + navigationBarSize.height - statusBarSize.height;
        }
        else
        {
            contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) / 2.0f - navigationBarSize.height + statusBarSize.height + 4;
        }
    }
    else
    {
        contentsFrame.origin.y = 0.0f;
    }
    
    view.frame = contentsFrame;
    return view;
}

#pragma mark - PopOutViewDelegate
-(void) didClickLeftButton;
{
    // Delete from Hard disk
    [Utility deleteFileFromPath:[Utility getDocumentFilePath:[_pictureNamesArray objectAtIndex:_selectedPictureNumber] withType:@"IMG"]];
    [[scrollViewsZoomArray objectAtIndex:_selectedPictureNumber] removeFromSuperview];
    [_pictureNamesArray removeObjectAtIndex:_selectedPictureNumber];
    [picturesImageArray removeObjectAtIndex:_selectedPictureNumber];
    [scrollViewsZoomArray removeObjectAtIndex:_selectedPictureNumber];
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    for (NSInteger i = _selectedPictureNumber; i < scrollViewsZoomArray.count; ++i)
    {
        [[scrollViewsZoomArray objectAtIndex:i] setFrame:CGRectMake(i * screenSize.width, 0, screenSize.width, screenSize.height)];
    }
    if (_selectedPictureNumber <= 0)
    {
        ++_selectedPictureNumber;
    }
    else
    {
        --_selectedPictureNumber;
    }
    if (_pictureNamesArray.count == 0)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        [_scrollViewFull setContentOffset:CGPointMake(screenSize.width * _selectedPictureNumber, 0)];
        
        [_scrollViewFull setContentSize:CGSizeMake(_scrollViewFull.frame.size.width * _pictureNamesArray.count, _scrollViewFull.frame.size.height)];
    }
}

#pragma mark - UIBarButtonItem Selector
-(void)deleteCurrentPagePhoto:(id)sender
{
    if (deletePictureView.isAppear)
    {
        [deletePictureView viewDisappearAnimationGenie];
    }
    else
    {
        [deletePictureView viewAppearAnimationGenie];
    }
}

#pragma mark - UIGestureRecognizer Selector
-(void)tapUIScrollViewHideBar:(UITapGestureRecognizer *)recignizer
{
    if (self.navigationController.navigationBarHidden)
    {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
        [self setTabBarController:self.tabBarController isHidden:NO animated:YES];
    }
    else
    {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
        [self setTabBarController:self.tabBarController isHidden:YES animated:YES];
    }
}

-(void)tapTwiceScrollViewZoomIn:(UITapGestureRecognizer *)recognizer
{
    //    CGPoint pointView = [recognizer locationInView:recognizer.view];
    //
    //    CGFloat newZoomScale = _scrollViewFull.zoomScale * 3.f;
    //    newZoomScale = MIN(newZoomScale, _scrollViewFull.maximumZoomScale);
    //    CGSize scrollViewSize = _scrollViewFull.bounds.size;
    //    CGFloat width = scrollViewSize.width / newZoomScale;
    //    CGFloat height = scrollViewSize.height / newZoomScale;
    //    CGFloat x = pointView.x - (width / 3.f);
    //    CGFloat y = pointView.y - (height / 3.f);
    //    NSLog(@"Before  _pictureNamesArray = %@", _pictureNamesArray);
    //    NSLog(@"After  _pictureNamesArray = %@", _pictureNamesArray);
    //    CGRect rectZoomIn = CGRectMake(x, y, width, height);
    //
    //    [_scrollViewFull zoomToRect:rectZoomIn animated:YES];
}

#pragma mark - UITabBar hidden
-(void)setTabBarController:(UITabBarController *)tabBarController isHidden:(BOOL)hide animated:(BOOL)animate
{
    float screenHeight = [UIScreen mainScreen].bounds.size.height;
    UIView *tabBarView = tabBarController.tabBar;
    float tabBarHeight = tabBarView.frame.size.height;
    if (hide)
    {
        if (animate)
        {
            [UIView animateWithDuration:0.1 animations:^{
                [tabBarView setFrame:CGRectMake(tabBarView.frame.origin.x, screenHeight + tabBarHeight, tabBarView.frame.size.width, tabBarView.frame.size.height)];
            }];
        }
        else
        {
            [tabBarView setFrame:CGRectMake(tabBarView.frame.origin.x, screenHeight + tabBarHeight, tabBarView.frame.size.width, tabBarView.frame.size.height)];
        }
    }
    else
    {
        if (animate)
        {
            [UIView animateWithDuration:0.1 animations:^{
                [tabBarView setFrame:CGRectMake(tabBarView.frame.origin.x, screenHeight - tabBarHeight, tabBarView.frame.size.width, tabBarView.frame.size.height)];
            }];
        }
        else
        {
            [tabBarView setFrame:CGRectMake(tabBarView.frame.origin.x, screenHeight - tabBarHeight, tabBarView.frame.size.width, tabBarView.frame.size.height)];
        }
    }
}

- (void)didReceiveMemoryWarning
{
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
