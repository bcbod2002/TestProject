//
//  PictureManagerView.m
//  MyBell
//
//  Created by shinsoft on 2014/6/25.
//  Copyright (c) 2014年 shinsoft. All rights reserved.
//

#import "PictureManagerView.h"

@implementation PictureManagerView
{
    __strong MPMoviePlayerController *moviePlayerControllerAll;
    NSInteger playingMovieControllerTag;
    UICollectionViewFlowLayout *previousFlowLayout;
    NSInteger deletePathCount;
    NSMutableArray *indexPathForCellArray;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor blackColor]];
    
        _pictureManagerCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) collectionViewLayout:[[PictureManagerFlowLayout alloc] init]];
        
        
        
        _pictureManagerCollectionView.delegate = self;
        _pictureManagerCollectionView.dataSource = self;
        [self addSubview:_pictureManagerCollectionView];
        [_pictureManagerCollectionView registerClass:[PictureManagerViewCell class] forCellWithReuseIdentifier:@"collectionViewCell"];
        [_pictureManagerCollectionView registerClass:[PictureManagerHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
        
        
        // Tap Cell To full Screen
//        UITapGestureRecognizer *tapCellToFullScreen = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapCellToFullScreen:)];
//        [tapCellToFullScreen setNumberOfTouchesRequired:1];
        
        _pictureMutableArray = [[NSMutableArray alloc] init];
        
        _moviethumbnailArray = [[NSMutableArray alloc] init];
        
        _pictureFiles = [[NSMutableArray alloc] init];
        _videoFiles = [[NSMutableArray alloc] init];
        
        // MPMoviePlayerController init
        _moviePlayerArray = [[NSMutableArray alloc] init];
        moviePlayerControllerAll = [[MPMoviePlayerController alloc] init];
        [moviePlayerControllerAll.view setFrame:CGRectMake(0, 0, 320, 328)];
        [moviePlayerControllerAll setControlStyle:MPMovieControlStyleEmbedded];
        [moviePlayerControllerAll setRepeatMode:MPMovieRepeatModeNone];
        [moviePlayerControllerAll setScalingMode:MPMovieScalingModeAspectFit];
        [moviePlayerControllerAll setMovieSourceType:MPMovieSourceTypeFile];
        [moviePlayerControllerAll setShouldAutoplay:NO];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackStateNotification:) name:MPMoviePlayerPlaybackStateDidChangeNotification object:moviePlayerControllerAll];
        
        [self loadFilesWithPicturesPath];
        [self loadFilesWithVideosPath];
        
        _flowLayoutTag = NoneFullScreenFlowLayout;
        _deletePathArray = [[NSMutableArray alloc] init];
        _nonDeletePathArray = [[NSMutableArray alloc] init];
        indexPathForCellArray = [[NSMutableArray alloc] init];
    }
    return self;
}

#pragma mark - Utility Load PicturePath and VideoPath
-(void)loadFilesWithPicturesPath
{
    NSArray *picaturePath = [Utility getDocumentFilesList:@"Picture"];
    [_pictureFiles removeAllObjects];
    
    for (NSInteger i = 0; i < picaturePath.count; ++i)
    {
        [_pictureFiles addObject:[UIImage imageWithContentsOfFile:[Utility getDocumentFilePath:picaturePath[i] withType:@"Picture"]]];
    }
}

-(void)loadFilesWithVideosPath
{
    NSArray *videosPath = [Utility getDocumentFilesList:@"Video"];
    [_videoFiles removeAllObjects];
    [_moviethumbnailArray removeAllObjects];
    
    
    
    for (NSInteger j = 0; j < videosPath.count; ++j)
    {
        NSString *moviePath = [Utility getDocumentFilePath:videosPath[j] withType:@"Video"];
        NSURL *movieURL = [NSURL fileURLWithPath:moviePath];
        MPMoviePlayerController *thumbnailMovieController = [[MPMoviePlayerController alloc] initWithContentURL:movieURL];
        UIImageView *thumbnailImageView = [[UIImageView alloc] initWithImage:[thumbnailMovieController thumbnailImageAtTime:0.5 timeOption:MPMovieTimeOptionExact]];
        [thumbnailImageView setFrame:CGRectMake(0, 0, 75, 75)];
        
        [_moviethumbnailArray addObject:thumbnailImageView];
        [_videoFiles addObject:movieURL];
        thumbnailMovieController = NULL;
    }
}

#pragma mark - UICollectionView
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
//    return _pictureFiles.count;
//    return 1;
    
    if (section == 0)
    {
        return _pictureFiles.count;
    }
    return _videoFiles.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PictureManagerViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionViewCell" forIndexPath:indexPath];
    
    if (cell.subviews.count >= 2)
    {
        for (NSInteger i = 1; i < cell.subviews.count; ++i)
        {
            [cell.subviews[i] removeFromSuperview];
        }
    }
    
    if (_flowLayoutTag == FullScreenFlowLayout)
    {
        // Picture
        if (indexPath.section == 0)
        {
            
            UIImageView *pictureView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 240)];
            [pictureView setImage:_pictureFiles[indexPath.row]];
            [cell addSubview:pictureView];
            [_pictureMutableArray addObject:pictureView];
        }
        
        // Video
        if (indexPath.section == 1)
        {
            [moviePlayerControllerAll setContentURL:[_videoFiles objectAtIndex:indexPath.row]];
            if (moviePlayerControllerAll.view.subviews.count >= 2)
            {
                [moviePlayerControllerAll.view.subviews[1] removeFromSuperview];
            }
            [moviePlayerControllerAll.view addSubview:[_moviethumbnailArray objectAtIndex:indexPath.row]];
            if (cell.subviews.count < 2)
            {
                [cell addSubview:moviePlayerControllerAll.view];
            }
                
            [moviePlayerControllerAll prepareToPlay];
        }
    }
    else
    {
        if (indexPath.section == 0)
        {
            UIImageView *pictureView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 77, 77)];
            [pictureView setImage:_pictureFiles[indexPath.row]];
            [cell addSubview:pictureView];
            [_pictureMutableArray addObject:pictureView];
        }
        if (indexPath.section == 1)
        {
            [[_moviethumbnailArray objectAtIndex:indexPath.row] setFrame:CGRectMake(0, 0, 77, 77)];
            [cell addSubview:[_moviethumbnailArray objectAtIndex:indexPath.row]];
        }
    }
    
    if (indexPathForCellArray.count > 0)
    {
        for (NSInteger i = 0; i < indexPathForCellArray.count; ++i)
        {
            if (indexPathForCellArray[i] == indexPath)
            {
                UIImageView *checkImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Check"]];
                [cell addSubview:checkImage];
            }
        }
    }
//    cell.tag = 0;
    return cell;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableView = nil;
    if (kind == UICollectionElementKindSectionHeader)
    {
        PictureManagerHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        NSString *headerTitle;
//        if (indexPath.section == 0)
//        {
//            headerTitle = [[NSString alloc] initWithFormat:@"Album"];
        headerTitle = NSLocalizedStringFromTable(@"ALBUM", @"InfoPlist", nil);
//        }
//        else
//        {
//            headerTitle = [[NSString alloc] initWithFormat:@"Videos"];
//        }
        headerView.titleLable.text = headerTitle;
        headerView.backgroundColor = [UIColor blackColor];
        
        reusableView = headerView;
    }

    return reusableView;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_editButtonState)
    {
        UIImageView *checkImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Check"]];
        [checkImage setFrame:CGRectMake(0, 0, 30, 30)];
        if ([collectionView cellForItemAtIndexPath:indexPath].tag == 0)
        {
            [[collectionView cellForItemAtIndexPath:indexPath] addSubview:checkImage];
            [collectionView cellForItemAtIndexPath:indexPath].tag = 1;
            [_deletePathArray addObject:[[Utility getDocumentFilesList:@"Picture"] objectAtIndex:indexPath.row]];
            [indexPathForCellArray addObject:indexPath];
            ++deletePathCount;
        }
        else
        {
            NSInteger checkImageLayerIndex = [collectionView cellForItemAtIndexPath:indexPath].subviews.count;
            NSString *nonCheckedImagePathString = [[Utility getDocumentFilesList:@"Picture"] objectAtIndex:indexPath.row];
            [_deletePathArray removeObject:nonCheckedImagePathString];
            [[collectionView cellForItemAtIndexPath:indexPath].subviews[checkImageLayerIndex - 1] removeFromSuperview];
            [collectionView cellForItemAtIndexPath:indexPath].tag = 0;
            --deletePathCount;
            [indexPathForCellArray removeObject:indexPath];
        }
    }
    else
    {
        if (_flowLayoutTag == NoneFullScreenFlowLayout)
        {
            [_pictureManagerCollectionView setCollectionViewLayout:[[PictureManagerFullScreenFlowLayout alloc] init] animated:YES];
            [_pictureManagerCollectionView setPagingEnabled:YES];
            [_pictureManagerCollectionView setContentOffset:CGPointMake(320 * (indexPath.section == 0 ? indexPath.row : _pictureFiles.count + indexPath.row), 0) animated:YES];
            _flowLayoutTag = FullScreenFlowLayout;
            
            // Pictures zoom to full
            for (NSInteger i = 0; i < _pictureMutableArray.count; ++i)
            {
                [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    [[_pictureMutableArray objectAtIndex:i] setFrame:CGRectMake(0, 0, 320, 240)];
                } completion:^(BOOL finished) {
                    //                    <#code#>
                }];
            }
            
            // Videos zoom to full
//            for (NSInteger i = 0; i < _moviethumbnailArray.count; ++i)
//            {
//                [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//                    [[_moviethumbnailArray objectAtIndex:i] setFrame:CGRectMake(0, 44, 320, 240)];
//                } completion:^(BOOL finished) {
//                    [[_moviethumbnailArray objectAtIndex:i] removeFromSuperview];
//                }];
//            }
//            if (indexPath.section == 1)
//            {
//                if ([_pictureManagerCollectionView cellForItemAtIndexPath:indexPath].subviews.count >= 2)
//                {
//                    for (NSInteger i = 1; i < [_pictureManagerCollectionView cellForItemAtIndexPath:indexPath].subviews.count; ++i)
//                    {
//                        [[_pictureManagerCollectionView cellForItemAtIndexPath:indexPath].subviews[i] removeFromSuperview];
//                    }
//                }
//                
//                [moviePlayerControllerAll setContentURL:[_videoFiles objectAtIndex:indexPath.row]];
//                [moviePlayerControllerAll.view addSubview:[_moviethumbnailArray objectAtIndex:indexPath.row]];
//                [[_pictureManagerCollectionView cellForItemAtIndexPath:indexPath] addSubview:moviePlayerControllerAll.view];
//                [moviePlayerControllerAll prepareToPlay];
//            }
            UISwipeGestureRecognizer *swipeDownBackOriginalSize = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeDownBackOriginalSize:)];
            [swipeDownBackOriginalSize setDirection:UISwipeGestureRecognizerDirectionDown];
            [_pictureManagerCollectionView addGestureRecognizer:swipeDownBackOriginalSize];
        }
    }
//    if (_flowLayoutTag == NoneFullScreenFlowLayout)
//    {
//        [_pictureManagerCollectionView setCollectionViewLayout:[[PictureManagerFullScreenFlowLayout alloc] init] animated:YES];
//        [_pictureManagerCollectionView setPagingEnabled:YES];
//        [_pictureManagerCollectionView setContentOffset:CGPointMake(320 * (indexPath.section == 0 ? indexPath.row : _pictureFiles.count + indexPath.row), 0) animated:YES];
//        _flowLayoutTag = FullScreenFlowLayout;
//        
//        // Pictures zoom to full
//        for (NSInteger i = 0; i < _pictureMutableArray.count; ++i)
//        {
//            [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//                [[_pictureMutableArray objectAtIndex:i] setFrame:CGRectMake(0, 44, 320, 240)];
//            } completion:^(BOOL finished) {
//                //                    <#code#>
//            }];
//        }
//        
//        // Videos zoom to full
//        for (NSInteger i = 0; i < _moviethumbnailArray.count; ++i)
//        {
//            [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//                [[_moviethumbnailArray objectAtIndex:i] setFrame:CGRectMake(0, 44, 320, 240)];
//            } completion:^(BOOL finished) {
//                [[_moviethumbnailArray objectAtIndex:i] removeFromSuperview];
//            }];
//        }
//        if (indexPath.section == 1)
//        {
//            if ([_pictureManagerCollectionView cellForItemAtIndexPath:indexPath].subviews.count >= 2)
//            {
//                for (NSInteger i = 1; i < [_pictureManagerCollectionView cellForItemAtIndexPath:indexPath].subviews.count; ++i)
//                {
//                    [[_pictureManagerCollectionView cellForItemAtIndexPath:indexPath].subviews[i] removeFromSuperview];
//                }
//            }
//        
//            [moviePlayerControllerAll setContentURL:[_videoFiles objectAtIndex:indexPath.row]];
//            [moviePlayerControllerAll.view addSubview:[_moviethumbnailArray objectAtIndex:indexPath.row]];
//            [[_pictureManagerCollectionView cellForItemAtIndexPath:indexPath] addSubview:moviePlayerControllerAll.view];
//            [moviePlayerControllerAll prepareToPlay];
//        }
//        UISwipeGestureRecognizer *swipeDownBackOriginalSize = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeDownBackOriginalSize:)];
//        [swipeDownBackOriginalSize setDirection:UISwipeGestureRecognizerDirectionDown];
//        [_pictureManagerCollectionView addGestureRecognizer:swipeDownBackOriginalSize];
//    }
}

//-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    if ([collectionViewLayout isKindOfClass:[PictureManagerFullScreenFlowLayout class]])
//    {
//        [[_pictureManagerCollectionView cellForItemAtIndexPath:indexPath].subviews[1] setFrame:CGRectMake(0, 0, 320, 240)];
//        return CGSizeMake(320, 240);
//    }
//    [[_pictureManagerCollectionView cellForItemAtIndexPath:indexPath].subviews[1] setFrame:CGRectMake(0, 0, 77, 77)];
//    return CGSizeMake(77, 77);
//}

-(void)reloadAllData
{
    [self loadFilesWithPicturesPath];
    [_pictureManagerCollectionView reloadData];
}

#pragma mark - MediaPlayer Delegate
-(UIImage *)handleThumbnailImageRequestFinishNotification:(NSNotification *)notificaton
{
    NSDictionary *userInfo = [notificaton userInfo];
    return [userInfo valueForKey:MPMoviePlayerThumbnailImageKey];
}

#pragma mark - UIImage adjust size
- (UIImage *)imageWithImageSimple:(UIImage *)image scaledToSize:(CGSize)newSize
{
    float width,height;
    if (image.size.width < newSize.width && image.size.height < newSize.height)
    {
        //如果已經小於newSize則不縮小
        width=image.size.width;
        height=image.size.height;
    }
    else if (image.size.height >= (newSize.height / newSize.width) * image.size.width)
    {
        width = image.size.width / image.size.height * newSize.height;
        height = newSize.height;
    }
    else
    {
        height = image.size.height / image.size.width * newSize.height;
        width = newSize.width;
    }
    newSize.width = width;
    newSize.height = height;
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    // Get the new image from the context
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    // End the context
    UIGraphicsEndImageContext();
    // Return the new image.
    return newImage;
}

//-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    return CGSizeMake(320, 240);
//}



-(void)handleTapCellToFullScreen:(UITapGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateEnded)
    {
        CGPoint initialPinchPoint = [sender locationInView:_pictureManagerCollectionView];
        NSIndexPath *tappedCellPath = [_pictureManagerCollectionView indexPathForItemAtPoint:initialPinchPoint];
//        NSLog(@"TappedCellPath = %@", tappedCellPath);
//        NSIndexPath *tappedCellPath = [_pictureManagerCollectionView indexPathForCell:sender.view.superview];
//        NSLog(@"what view ??", [_pictureManagerCollectionView indexPathForCell:sender.view]);
        if (tappedCellPath != nil)
        {
            
            [_pictureManagerCollectionView setCollectionViewLayout:[[PictureManagerFullScreenFlowLayout alloc] init] animated:YES];
            [_pictureManagerCollectionView removeGestureRecognizer:sender];
            [_pictureManagerCollectionView setPagingEnabled:YES];
            [_pictureManagerCollectionView setContentOffset:CGPointMake(320 * tappedCellPath.row, 0) animated:YES];
//            for (NSInteger i = 0; i < _pictureMutableAttay.count; ++i)
//            {
//                [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//                    [[_pictureMutableAttay objectAtIndex:i] setFrame:CGRectMake(0, 0, 320, 240)];
//                } completion:^(BOOL finished) {
////                    <#code#>
//                }];
//            }
            
//            [[_videoFiles objectAtIndex:tappedCellPath.row] setControlStyle:MPMovieControlStyleEmbedded];
//            [[[_videoFiles objectAtIndex:tappedCellPath.row] view] setFrame:CGRectMake(0, 0, 320, 240)];
//            [[_videoFiles objectAtIndex:tappedCellPath.row] play];
//            [[_videoMutableArray objectAtIndex:tappedCellPath.row] removeFromSuperview];
            
//            [[_pictureManagerCollectionView cellForItemAtIndexPath:tappedCellPath].subviews[1] setFrame:CGRectMake(0, 0, 320, 240)];
//            [[_moviethumbnailArray objectAtIndex:tappedCellPath.row] setFrame:CGRectMake(0, 0, 320, 240)];
            [[_moviethumbnailArray objectAtIndex:tappedCellPath.row] removeFromSuperview];
//            [[_moviethumbnailArray objectAtIndex:tappedCellPath.row] setFrame:CGRectMake(0, 0, 320, 240)];
//            NSString *movieString = [Utility getDocumentFilePath:_videosPath[tappedCellPath.row] withType:@"Video"];
//            NSURL *movieFullURL = [NSURL fileURLWithPath:movieString];

//            [_moviePlayerOne setContentURL:_videoFiles[tappedCellPath.row]];
//            NSLog(@"filePath = %@", _videoFiles[tappedCellPath.row]);
//            [_moviePlayerOne setControlStyle:MPMovieControlStyleEmbedded];
//            [_moviePlayerOne setRepeatMode:MPMovieRepeatModeNone];
//            [_moviePlayerOne setMovieSourceType:MPMovieSourceTypeFile];
//            [_moviePlayerOne setScalingMode:MPMovieScalingModeAspectFit];
//            [_moviePlayerOne setShouldAutoplay:NO];
//            [_moviePlayerOne prepareToPlay];
//            [_moviePlayerOne.view setFrame:CGRectMake(0, 0, 320, 240)];
////            [moviePlayerOne play];
//            [[_pictureManagerCollectionView cellForItemAtIndexPath:tappedCellPath] addSubview:_moviePlayerOne.view];
//            [[_moviethumbnailArray objectAtIndex:tappedCellPath.row] addSubview:moviePlayer.view];
            
            
//            UISwipeGestureRecognizer *swipeDownBackOriginalSize = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeDownBackOriginalSize:)];
//            [swipeDownBackOriginalSize setDirection:UISwipeGestureRecognizerDirectionDown];
//            [_pictureManagerCollectionView addGestureRecognizer:swipeDownBackOriginalSize];
        }
    }
}

-(void)handleSwipeDownBackOriginalSize:(UISwipeGestureRecognizer *)sender
{
//    CGPoint initialSwipePoint = [sender locationInView:_pictureManagerCollectionView];
//    NSIndexPath *swipedCellPath = [_pictureManagerCollectionView indexPathForItemAtPoint:initialSwipePoint];
//    
//    if (swipedCellPath != nil)
//    {
        [_pictureManagerCollectionView setCollectionViewLayout:[[PictureManagerFlowLayout alloc] init] animated:YES];
        [_pictureManagerCollectionView setPagingEnabled:NO];
        [_pictureManagerCollectionView removeGestureRecognizer:sender];
        for (NSInteger i = 0; i < _pictureMutableArray.count; ++i)
        {
            [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                [[_pictureMutableArray objectAtIndex:i] setFrame:CGRectMake(0, 0, 77, 77)];
            } completion:^(BOOL finished) {
                //                <#code#>
            }];
        }
        
        [moviePlayerControllerAll.view removeFromSuperview];
        
        for (NSInteger j = 0; j < _moviethumbnailArray.count; ++j)
        {
            [[_moviethumbnailArray objectAtIndex:j] removeFromSuperview];
            [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                [[_moviethumbnailArray objectAtIndex:j] setFrame:CGRectMake(0, 0, 77, 77)];
            } completion:^(BOOL finished) {
                //                <#code#>
            }];
        }
        
//        UITapGestureRecognizer *tapCellToFullScreen = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapCellToFullScreen:)];
//        [tapCellToFullScreen setNumberOfTouchesRequired:1];
//        [_pictureManagerCollectionView addGestureRecognizer:tapCellToFullScreen];
        
        _flowLayoutTag = NoneFullScreenFlowLayout;
        [self reloadAllData];
//    }
}

#pragma mark - NSNotificationCenter
-(void)playbackStateNotification:(NSNotification *)notification
{
//    NSLog(@"What?? = %ld", (long)_moviePlayerOne.playbackState);
    
    if (moviePlayerControllerAll.playbackState == MPMoviePlaybackStatePlaying)
    {
        if (moviePlayerControllerAll.view.subviews.count >= 2)
        {
            for (NSInteger i = 1; i < moviePlayerControllerAll.view.subviews.count; ++i)
            {
                [moviePlayerControllerAll.view.subviews[i] removeFromSuperview];
            }
        }
    }
}

#pragma mark - UIButton
-(void)moviePlayerOnePlayButton:(UITapGestureRecognizer *)sender
{
//    NSLog(@"NO NO NO NO NO NO NO NO");
//    UIButton *tmpButton = sender;
    [sender.view.superview removeFromSuperview];
//    [[sender superview] removeFromSuperview];
//    [_moviePlayerOne prepareToPlay];
//    [_moviePlayerOne play];
}


#pragma mark - Delete Picture
-(void)deletePicturesWithState:(BOOL)state
{
    if (state && (indexPathForCellArray.count > 0))
    {
        UIAlertView *checkDeleteAlertView = [[UIAlertView alloc] initWithTitle:NSLocalizedStringFromTable(@"REMOVEPICTURESSURE", @"InfoPlist", nil) message:NSLocalizedStringFromTable(@"REMOVESUREORNOT", @"InfoPlist", nil) delegate:self cancelButtonTitle:NSLocalizedStringFromTable(@"YES", @"InfoPlist", nil) otherButtonTitles:NSLocalizedStringFromTable(@"NO", @"InfoPlist", nil), nil];
        [checkDeleteAlertView show];
//        if (deletePathCount > 0)
//        {
//            for (NSString *removePathString in _deletePathArray)
//            {
//                NSLog(@"[Utility getDocumentFilePath:removePathString withType = %@", [Utility getDocumentFilePath:removePathString withType:@"Picture"]);
//                [Utility deleteFileFromPath:[Utility getDocumentFilePath:removePathString withType:@"Picture"]];
//            }
//            [self reloadAllData];
//        }
//        [_deletePathArray removeAllObjects];
//        [_nonDeletePathArray removeAllObjects];
    }
    else
    {
        deletePathCount = 0;
        [_deletePathArray removeAllObjects];
        [_nonDeletePathArray removeAllObjects];
        [indexPathForCellArray removeAllObjects];
        return;
    }
}

#pragma mark - UIAlertView Delegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        if (deletePathCount > 0)
        {
            for (NSString *removePathString in _deletePathArray)
            {
                [Utility deleteFileFromPath:[Utility getDocumentFilePath:removePathString withType:@"Picture"]];
            }
        }
    }
    else
    {
        
        for (NSInteger i = 0; i < _pictureFiles.count; ++i)
        {
            NSIndexPath *tmpIndexPath = [NSIndexPath indexPathForRow:i inSection:0];
            
            NSInteger checkImageLayerLocation = [_pictureManagerCollectionView cellForItemAtIndexPath:tmpIndexPath].subviews.count;
            if (checkImageLayerLocation >= 3)
            {
                [[_pictureManagerCollectionView cellForItemAtIndexPath:tmpIndexPath].subviews[checkImageLayerLocation - 1] removeFromSuperview];
            }
        }
    }
    [_deletePathArray removeAllObjects];
    [_nonDeletePathArray removeAllObjects];
    NSInteger numberOfItems = [_pictureManagerCollectionView numberOfItemsInSection:0];
    for (NSInteger i = 0; i < numberOfItems; ++i)
    {
        NSIndexPath *indexPathOfCell = [NSIndexPath indexPathForItem:i inSection:0];
        [_pictureManagerCollectionView cellForItemAtIndexPath:indexPathOfCell].tag = 0;
    }
    [indexPathForCellArray removeAllObjects];
    [self reloadAllData];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end