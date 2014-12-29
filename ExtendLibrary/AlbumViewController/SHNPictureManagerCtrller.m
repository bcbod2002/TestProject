//
//  SHINPictureManagerCtrller.m
//  EasyCam
//
//  Created by shinsoft on 2014/1/27.
//  Copyright (c) 2014年 shinsoft. All rights reserved.
//

#import "SHNPictureManagerCtrller.h"
#import "ImageCell.h"
#import "Utility.h"

@interface SHINPictureManagerCtrller ()
{
    BOOL editButtonTag;
    AlbumFullViewController *albumFullViewController;
    UICollectionView *collectionViewPictureManager;
    NSMutableArray *pictureImagesArray;
    NSArray *picturePathArray;
    NSMutableArray *deletePathArray;
    NSMutableArray *shareImagesArray;
    NSMutableArray *indexPathForCellArray;
    NSDictionary *picturesSectionsDictionary;
    NSMutableArray *picturesInSection;
    NSMutableArray *pictureSectionArray;
    
    NSArray *leftButtonArray;
}

@end

@implementation SHINPictureManagerCtrller
{
    bool canDelete;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    editButtonTag = NO;
    albumFullViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"AlbumFull"];
    // Load Picture from File
    pictureImagesArray = [[NSMutableArray alloc] init];
    
    // Delete Picture Array and Cell relate and Picture Date Array
    deletePathArray = [[NSMutableArray alloc] init];
    indexPathForCellArray = [[NSMutableArray alloc] init];
    picturesSectionsDictionary = [[NSDictionary alloc] init];
    picturesInSection = [[NSMutableArray alloc] init];
    
    // Share Picture Array
    shareImagesArray = [[NSMutableArray alloc] init];
    
    // Screen Size
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    // Navigation Bar Size
    CGSize navigationBarSize = self.navigationController.navigationBar.frame.size;
    // Tab Bar Size
    CGSize tabBarSize = self.tabBarController.tabBar.frame.size;
    // Status Bar Size
    CGSize statusBarSize = [UIApplication sharedApplication].statusBarFrame.size;
    //
    CGFloat allTopBarHeight = statusBarSize.height + navigationBarSize.height;
    
    // New Album Manager
    collectionViewPictureManager = [[UICollectionView alloc] initWithFrame:CGRectMake(0, allTopBarHeight, screenSize.width, screenSize.height - allTopBarHeight - tabBarSize.height) collectionViewLayout:[[PictureManagerFlowLayout alloc] init]];
    [collectionViewPictureManager registerClass:[PictureManagerViewCell class] forCellWithReuseIdentifier:@"collectionViewCell"];
    [collectionViewPictureManager registerClass:[PictureManagerHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
    collectionViewPictureManager.delegate = self;
    collectionViewPictureManager.dataSource = self;
    [self.view addSubview:collectionViewPictureManager];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    UIBarButtonItem *leftButtonTrash = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(deleteImagesAction:)];
    UIBarButtonItem *leftButtonShare = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(shareImagesAction:)];
    leftButtonArray = [[NSArray alloc] initWithObjects:leftButtonShare, leftButtonTrash, nil];
    
    [self loadFileFromPicturePathInArray];
    [collectionViewPictureManager reloadData];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    if (pictureImagesArray.count > 17)
    {
        [collectionViewPictureManager setContentOffset:CGPointMake(0, collectionViewPictureManager.contentSize.height - collectionViewPictureManager.frame.size.height)];
    }
    
//    UIBarButtonItem *leftButtonTrash = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(deleteImagesAction:)];
//    UIBarButtonItem *leftButtonShare = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(shareImagesAction:)];
//    leftButtonArray = [[NSArray alloc] initWithObjects:leftButtonShare, leftButtonTrash, nil];
}

-(void)loadFileFromPicturePathInArray
{
    picturePathArray = [Utility getDocumentFilesList:@"IMG"];
    //    picturePathArray = [[picturePathArray reverseObjectEnumerator] allObjects];
    picturesSectionsDictionary = [self collectionHeaderTitleDateSeparate];
    [pictureImagesArray removeAllObjects];
    for (NSString *picturePath in picturePathArray)
    {
        [pictureImagesArray addObject:[UIImage imageWithContentsOfFile:[Utility getDocumentFilePath:picturePath withType:@"IMG"]]];
    }
}

#pragma mark - String Separated
-(NSDictionary *)collectionHeaderTitleDateSeparate
{
    NSMutableArray *titleSeparatedArray = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < picturePathArray.count; ++i)
    {
        NSString *sectionTitle = [[picturePathArray[i] componentsSeparatedByString:@"_"] objectAtIndex:0];
        if (titleSeparatedArray.count <= 0)
        {
            [titleSeparatedArray addObject:sectionTitle];
        }
        else
        {
            if (![[titleSeparatedArray lastObject] isEqualToString:sectionTitle])
            {
                [titleSeparatedArray addObject:sectionTitle];
            }
        }
    }
    
    
    NSMutableDictionary *sectionImageDictionary = [[NSMutableDictionary alloc] init];
    for (NSString *pictureTitle in titleSeparatedArray)
    {
        NSMutableArray *rowImageArray = [[NSMutableArray alloc] init];
        for (NSString *picturePath in picturePathArray)
        {
            if ([[[picturePath componentsSeparatedByString:@"_"] objectAtIndex:0] isEqualToString:pictureTitle])
            {
                //                NSLog(@"picturePath = %@", picturePath);
                //                [rowArray addObject:picturePath];
                [rowImageArray addObject:[UIImage imageWithContentsOfFile:[Utility getDocumentFilePath:picturePath withType:@"IMG"]]];
            }
        }
        [sectionImageDictionary setObject:rowImageArray forKey:pictureTitle];
    }
    //    NSLog(@"sectionDictionary.allKeys = %@", sectionDictionary.allKeys);
    
    return sectionImageDictionary;
}



#pragma mark - NSIndexPath transform One-dimensional Array Number
-(NSInteger)transformOneDimensionalArrayNumberWithIndexPath:(NSIndexPath *)indexpath
{
    NSInteger arrayNumber = 0;
    
    NSArray *sectionTitleArray = picturesSectionsDictionary.allKeys;
    sectionTitleArray = [sectionTitleArray sortedArrayUsingSelector:@selector(compare:)];
    for (NSInteger i = 0; i < indexpath.section; ++i)
    {
        NSArray *rowPathArray = [picturesSectionsDictionary objectForKey:sectionTitleArray[i]];
        arrayNumber += rowPathArray.count;
    }
    arrayNumber += indexpath.row;
    
    return arrayNumber;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return picturesSectionsDictionary.allKeys.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSArray *pictureTitleArray = picturesSectionsDictionary.allKeys;
    pictureTitleArray = [pictureTitleArray sortedArrayUsingSelector:@selector(compare:)];
    NSArray *rowImagesArray = [picturesSectionsDictionary objectForKey:pictureTitleArray[section]];
    return rowImagesArray.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PictureManagerViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionViewCell" forIndexPath:indexPath];
    if (!cell)
    {
        cell = [[PictureManagerViewCell alloc] init];
    }
    if (cell.subviews.count >= 2)
    {
        for (NSInteger i = cell.subviews.count - 1; i > 0; --i)
        {
            [cell.subviews[i] removeFromSuperview];
        }
    }
    
    UIImageView *pictureView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 77, 77)];
    
    // New Version
    NSArray *sectionTitleArray = picturesSectionsDictionary.allKeys;
    sectionTitleArray = [sectionTitleArray sortedArrayUsingSelector:@selector(compare:)];
    NSArray *rowImagesArray = [picturesSectionsDictionary objectForKey:sectionTitleArray[indexPath.section]];
    [pictureView setImage:rowImagesArray[indexPath.row]];
    [cell addSubview:pictureView];

    if (indexPathForCellArray.count > 0)
    {
        for (NSIndexPath *checkIndexPath in indexPathForCellArray)
        {
            if ((checkIndexPath.section == indexPath.section) && (checkIndexPath.row == indexPath.row))
            {
                UIImageView *checkImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Check_mark"]];
                [cell addSubview:checkImage];
            }
        }

    }
    
    return cell;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableView = nil;
    if (kind == UICollectionElementKindSectionHeader)
    {
        PictureManagerHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        NSArray *sectionTitleArray = picturesSectionsDictionary.allKeys;
        sectionTitleArray = [sectionTitleArray sortedArrayUsingSelector:@selector(compare:)];
        
        // Date Formate Transfotmer
        NSDateFormatter *oldDateFormatter = [[NSDateFormatter alloc] init];
        NSDateFormatter *newDateFormatter = [[NSDateFormatter alloc] init];
        [oldDateFormatter setDateFormat:@"yyyyMMdd"];
        [newDateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSDate *date = [oldDateFormatter dateFromString:[sectionTitleArray objectAtIndex:indexPath.section]];
        NSString *lastDateString = [NSString stringWithFormat:@"%@ : %@", NSLocalizedStringFromTable(@"DATE", @"Localizable", nil), [newDateFormatter stringFromDate:date]];
        
        
        [headerView.titleLable setText:lastDateString];
        reusableView = headerView;
    }
    return reusableView;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger selectItemInteger = [self transformOneDimensionalArrayNumberWithIndexPath:indexPath];
    if (editButtonTag)
    {
        UIImageView *checkImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Check_mark"]];
        [checkImage setFrame:CGRectMake(0, 0, 30, 30)];
        
        if (![deletePathArray containsObject:[[Utility getDocumentFilesList:@"IMG"] objectAtIndex:selectItemInteger]])
        {
            // cell.tag == 0 Image unselected
            [[collectionView cellForItemAtIndexPath:indexPath] addSubview:checkImage];
            [collectionView cellForItemAtIndexPath:indexPath].tag = 1;
            [deletePathArray addObject:[[Utility getDocumentFilesList:@"IMG"] objectAtIndex:selectItemInteger]];
            NSString *imageFileName = [[Utility getDocumentFilesList:@"IMG"] objectAtIndex:selectItemInteger];
            [shareImagesArray addObject:[Utility getDocumentFilePath:imageFileName withType:@"IMG"]];
            [indexPathForCellArray addObject:indexPath];
        }
        else
        {
            // cell.tag = 1 Image selected
            NSInteger checkImageLayerIndex = [collectionView cellForItemAtIndexPath:indexPath].subviews.count;
            NSString *nonCheckedImagePathString = [[Utility getDocumentFilesList:@"IMG"] objectAtIndex:selectItemInteger];
            [deletePathArray removeObject:nonCheckedImagePathString];
            NSString *imageFileName = [[Utility getDocumentFilesList:@"IMG"] objectAtIndex:selectItemInteger];
            [shareImagesArray removeObject:[Utility getDocumentFilePath:imageFileName withType:@"IMG"]];
            [[collectionView cellForItemAtIndexPath:indexPath].subviews[checkImageLayerIndex - 1] removeFromSuperview];
            [collectionView cellForItemAtIndexPath:indexPath].tag = 0;
            [indexPathForCellArray removeObject:indexPath];
        }
        if (deletePathArray.count > 0)
        {
            [[self.navigationItem.leftBarButtonItems objectAtIndex:0] setEnabled:YES];
            [[self.navigationItem.leftBarButtonItems objectAtIndex:1] setEnabled:YES];
        }
        else
        {
            [[self.navigationItem.leftBarButtonItems objectAtIndex:0] setEnabled:NO];
            [[self.navigationItem.leftBarButtonItems objectAtIndex:1] setEnabled:NO];
        }
    }
    else
    {
        // Set variables to AlbumFullViewController
        // Set Images and Names and Select picture number
        NSMutableArray *setPicturesNamesArray = [[NSMutableArray alloc] initWithArray:picturePathArray];
        [albumFullViewController setPictureNamesArray:setPicturesNamesArray];
        [albumFullViewController setSelectedPictureNumber:selectItemInteger];
        [self.navigationController pushViewController:albumFullViewController animated:YES];
    }
}

#pragma mark - UIButton Action
- (IBAction)editButtonAction:(id)sender
{
    if (editButtonTag)
    {
        self.navigationItem.leftBarButtonItems = nil;
        self.navigationItem.rightBarButtonItem = nil;
        UIBarButtonItem *editBarButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedStringFromTable(@"SELECT", @"Localizable", nil) style:UIBarButtonItemStyleBordered target:self action:@selector(editButtonAction:)];
        self.navigationItem.rightBarButtonItem = editBarButton;
        editButtonTag = NO;
        [deletePathArray removeAllObjects];
        [shareImagesArray removeAllObjects];
        [indexPathForCellArray removeAllObjects];
        [self loadFileFromPicturePathInArray];
        [collectionViewPictureManager reloadData];
    }
    else
    {
        self.navigationItem.leftBarButtonItems = leftButtonArray;
        [[self.navigationItem.leftBarButtonItems objectAtIndex:0] setEnabled:NO];
        [[self.navigationItem.leftBarButtonItems objectAtIndex:1] setEnabled:NO];
        self.navigationItem.rightBarButtonItem = nil;
        UIBarButtonItem *cancelBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(editButtonAction:)];
        self.navigationItem.rightBarButtonItem = cancelBarButton;
        editButtonTag = YES;
    }
}

- (void) deleteImagesAction:(id)sender
{
    if (editButtonTag)
    {
        if (deletePathArray.count)
        {
            UIAlertView *checkDeleteAlertView = [[UIAlertView alloc] initWithTitle:NSLocalizedStringFromTable(@"REMOVEPICTURESSURE", @"Localizable", nil) message:NSLocalizedStringFromTable(@"REMOVESUREORNOT", @"Localizable", nil) delegate:self cancelButtonTitle:NSLocalizedStringFromTable(@"YES", @"Localizable", nil) otherButtonTitles:NSLocalizedStringFromTable(@"NO", @"Localizable", nil), nil];
            checkDeleteAlertView.tag = 0;
            [checkDeleteAlertView show];
        }
        
        editButtonTag = NO;
    }
    else
    {
        editButtonTag = YES;
    }
}

- (void) shareImagesAction:(id)sender
{
    if (editButtonTag)
    {
        if (shareImagesArray.count)
        {
            UIAlertView *checkShareAlertView = [[UIAlertView alloc] initWithTitle:NSLocalizedStringFromTable(@"REMOVEPICTURESSURE", @"Localizable", nil) message:NSLocalizedStringFromTable(@"SHARESUREORNOT", @"Localizable", nil) delegate:self cancelButtonTitle:NSLocalizedStringFromTable(@"YES", @"Localizable", nil) otherButtonTitles:NSLocalizedStringFromTable(@"NO", @"Localizable", nil), nil];
            checkShareAlertView.tag = 1;
            [checkShareAlertView show];
        }
        editButtonTag = NO;
    }
    else
    {
        editButtonTag = YES;
    }
}

#pragma mark - UIAlertView Delegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    __block NSInteger copySuccessTag = 0;
    switch (alertView.tag)
    {
        case 0:
        {
            if (buttonIndex == 0)
            {
                if (deletePathArray.count > 0)
                {
                    for (NSString *removePathString in deletePathArray)
                    {
                        [Utility deleteFileFromPath:[Utility getDocumentFilePath:removePathString withType:@"IMG"]];
                    }
                }
            }
            else
            {
                for (NSInteger i = 0; i < picturePathArray.count; ++i)
                {
                    NSIndexPath *checkIndexPath = [NSIndexPath indexPathForRow:i inSection:0];
                    NSInteger checkImageLayerLocation = [collectionViewPictureManager cellForItemAtIndexPath:checkIndexPath].subviews.count - 1;
                    if (checkImageLayerLocation >= 3)
                    {
                        [[collectionViewPictureManager cellForItemAtIndexPath:checkIndexPath].subviews[checkImageLayerLocation] removeFromSuperview];
                    }
                }
            }
            NSInteger numberOfItems = [collectionViewPictureManager numberOfItemsInSection:0];
            for (NSInteger i = 0; i < numberOfItems; ++i)
            {
                NSIndexPath *indexPathOfCell = [NSIndexPath indexPathForItem:i inSection:0];
                [collectionViewPictureManager cellForItemAtIndexPath:indexPathOfCell].tag = 0;
            }
            for (NSIndexPath *index in indexPathForCellArray)
            {
                [collectionViewPictureManager cellForItemAtIndexPath:index].tag = 0;
            }
            //            [deletePathArray removeAllObjects];
            //            [indexPathForCellArray removeAllObjects];
            //            [self loadFileFromPicturePathInArray];
            //            [collectionViewPictureManager reloadData];
            break;
        }
        case 1:
        {
            if (buttonIndex == 0)
            {
                ALAssetsLibrary *assetLibrary = [[ALAssetsLibrary alloc] init];
                for (NSString *readySharePath in shareImagesArray)
                {
                    NSData *tmpData = [NSData dataWithContentsOfFile:readySharePath];
                    [assetLibrary writeImageDataToSavedPhotosAlbum:tmpData metadata:nil completionBlock:^(NSURL *assetURL, NSError *error)
                     {
                         ALAuthorizationStatus status = [ALAssetsLibrary authorizationStatus];
                         ++copySuccessTag;
                         if (status == ALAuthorizationStatusDenied)
                         {
                             UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedStringFromTable(@"PHOTOSDENIED", @"Localizable", nil) message:NSLocalizedStringFromTable(@"PLEASEOPENACCESS", @"Localizable", nil) delegate:nil cancelButtonTitle:NSLocalizedStringFromTable(@"YES", @"Localizable", nil) otherButtonTitles:nil];
                             [alertView show];
                         }
                         else if (status == ALAuthorizationStatusAuthorized)
                         {
                             if (copySuccessTag == 1)
                             {
                                 UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedStringFromTable(@"PHOTOSSUCCESS", @"Localizable", nil) message:NSLocalizedStringFromTable(@"PHOTOSCOMPLETE", @"Localizable", nil) delegate:nil cancelButtonTitle:NSLocalizedStringFromTable(@"YES", @"Localizable", nil) otherButtonTitles:nil];
                                 [alertView show];
                             }
                         }
                     }];
                }
            }
            
            break;
        }
            
        default:
            break;
    }
    [deletePathArray removeAllObjects];
    [shareImagesArray removeAllObjects];
    [indexPathForCellArray removeAllObjects];
    [self loadFileFromPicturePathInArray];
    [collectionViewPictureManager reloadData];
    self.navigationItem.leftBarButtonItems = nil;
    //    UIBarButtonItem *editBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystem target:self action:@selector(editAction:)];
    UIBarButtonItem *editBarButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedStringFromTable(@"SELECT", @"Localizable", nil) style:UIBarButtonItemStyleBordered target:self action:@selector(editButtonAction:)];
    self.navigationItem.rightBarButtonItem = editBarButton;
}
@end
