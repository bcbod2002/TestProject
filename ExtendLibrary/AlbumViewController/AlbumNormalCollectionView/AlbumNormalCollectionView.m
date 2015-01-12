//
//  AlbumNormalCollectionView.m
//  TestProject
//
//  Created by SSPC139 on 2015/1/8.
//  Copyright (c) 2015年 shinsoft. All rights reserved.
//

#import "AlbumNormalCollectionView.h"

@implementation AlbumNormalCollectionView
{
    UICollectionView *albumNormalCollectionView;
    NSString *albumReuse;
    NSString *headerReuse;
    NSArray *albumImageArray;
    NSArray *albumFilePathArray;
    NSArray *albumDateArray;
    NSMutableArray *deleteItemArray;
    
}
-(instancetype)initWithFrame:(CGRect)frame WithWidthCellNumber:(NSInteger)cellNumber
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _deleteTag = NO;
        deleteItemArray = [[NSMutableArray alloc] init];
        albumReuse = @"AlbumNormalReuse";
        headerReuse = @"AlbumHeaderReuse";
        AlbumNormalFlowLayout *albumNormalFlowLayout = [[AlbumNormalFlowLayout alloc] initWithWidthCellNumber:cellNumber WithLineSpacing:5.f AndCollectionViewSize:frame.size];
        albumNormalCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) collectionViewLayout:albumNormalFlowLayout];
        [albumNormalCollectionView registerClass:[AlbumNormalCollectionViewCell class] forCellWithReuseIdentifier:albumReuse];
        [albumNormalCollectionView registerClass:[AlbumNormalHeaderCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerReuse];
        [albumNormalCollectionView setScrollEnabled:YES];
        [albumNormalCollectionView setShowsHorizontalScrollIndicator:NO];
        [albumNormalCollectionView setShowsVerticalScrollIndicator:YES];
        albumNormalCollectionView.delegate = self;
        albumNormalCollectionView.dataSource = self;
        [self addSubview:albumNormalCollectionView];
        NSLog(@"init");
    }
    return self;
}

#pragma mark - UICollectionView DataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
//    return albumDateArray.count;
    return 10;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 50;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    AlbumNormalCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:albumReuse forIndexPath:indexPath];
    
//    [cell se]
    
    return cell;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusebleView = nil;
    if (kind == UICollectionElementKindSectionHeader)
    {
        AlbumNormalHeaderCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerReuse forIndexPath:indexPath];
        [headerView setTitleText:[albumDateArray objectAtIndex:indexPath.section]];
        
        reusebleView = headerView;
    }
    return reusebleView;
}

#pragma mark - UICollectionView Delegate
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}
/**
 *  Cell End Display
 */
-(void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}
/**
 *  Header End Display
 */
-(void)collectionView:(UICollectionView *)collectionView didEndDisplayingSupplementaryView:(UICollectionReusableView *)view forElementOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath
{
    
}


#pragma mark - UICollectionView Other Operations Public
-(void)setAlbumImagesContentArray:(NSArray *)imagesArray
{
    albumImageArray = imagesArray;
    [albumNormalCollectionView reloadData];
}

-(void)setAlbumImageFilePathArray:(NSArray *)filePathArray
{
    albumFilePathArray = filePathArray;
}

-(void)setAlbumDateArray:(NSArray *)dateArray WithDateFormatter:(NSDateFormatter *)dateFormatter
{
    albumDateArray = [self transformDateArrayToStringArray:dateArray WithDateFormatter:dateFormatter];
}

#pragma marrk - UICollectionView Ither Operations Private
-(NSArray *)transformDateArrayToStringArray:(NSArray *)dateArray WithDateFormatter:(NSDateFormatter *)dateFormatter
{
    NSMutableArray *newDateStringArray = [[NSMutableArray alloc] init];
    for (NSDate *oldDate in dateArray)
    {
        NSString *transformDateString;
        transformDateString = [dateFormatter stringFromDate:oldDate];
        [newDateStringArray addObject:transformDateString];
    }
    return newDateStringArray;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
