//
//  MultiSplitCollectionView.m
//  TestProject
//
//  Created by shinsoft on 2014/5/30.
//  Copyright (c) 2014年 Goston. All rights reserved.
//

#import "MultiSplitCollectionView.h"

@implementation MultiSplitCollectionView
{
    UICollectionView *splitCollectionView;
    OneSplitFlowLayout *oneSplitFlowLayout;
    FourSplitFlowLayout *fourSplitFlowLayout;
    NineSplitFlowLayout *nineSplitFlowLayout;
    SixteenSplitFlowLayout *sixteenSplitFlowLayout;
    BOOL transformOneTag;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // Initialization code
        fourSplitFlowLayout = [[FourSplitFlowLayout alloc] init];
        oneSplitFlowLayout = [[OneSplitFlowLayout alloc] init];
        nineSplitFlowLayout = [[NineSplitFlowLayout alloc] init];
        sixteenSplitFlowLayout = [[SixteenSplitFlowLayout alloc] init];
        _previousSplitNumber = FoursplitNumber;
        _nowSplitNumber = OneSplitNumber;
        
        [self setBackgroundColor:[UIColor darkGrayColor]];
        splitCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) collectionViewLayout:fourSplitFlowLayout];
         [splitCollectionView registerClass:[MultiSplitCollectionViewCell class] forCellWithReuseIdentifier:@"collectionViewCell"];
        splitCollectionView.delegate = self;
        splitCollectionView.dataSource = self;
        [splitCollectionView setPagingEnabled:YES];
        [splitCollectionView setMultipleTouchEnabled:NO];
        [self addSubview:splitCollectionView];
        transformOneTag = NO;
        
        _nowPage = 0;
        _totalPage = [splitCollectionView numberOfItemsInSection:0] / _nowSplitNumber;
        
        [splitCollectionView selectItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionLeft];
        [self collectionView:splitCollectionView didSelectItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    }
    return self;
}

#pragma mark - UICollectopmView DataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 16;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MultiSplitCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionViewCell" forIndexPath:indexPath];
    [cell setIndexPath:indexPath];
    [cell setDelegate:self];
    
    if (_selectedIndexPath == indexPath)
    {
        [cell.contentView.layer setBorderColor:[UIColor whiteColor].CGColor];
    }
    else
    {
        [cell.contentView.layer setBorderColor:[UIColor blueColor].CGColor];
    }
    
    return cell;
}

#pragma mark - UICollectionView Delegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    CALayer *borderLayer = [collectionView cellForItemAtIndexPath:indexPath].contentView.layer;
    [borderLayer setBorderColor:[UIColor whiteColor].CGColor];
    _selectedIndexPath = indexPath;
}

-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    CALayer *borderLayer = [collectionView cellForItemAtIndexPath:indexPath].contentView.layer;
    [borderLayer setBorderColor:[UIColor blueColor].CGColor];
}

-(void)changeSplitFlowLayout:(SplitNumber)splitnumber
{
    switch (splitnumber)
    {
        case OneSplitNumber:
        {
            [splitCollectionView setCollectionViewLayout:oneSplitFlowLayout animated:YES];
            transformOneTag = YES;
            break;
        }
        case FoursplitNumber:
        {
            [splitCollectionView setCollectionViewLayout:fourSplitFlowLayout animated:YES];
            [splitCollectionView setContentOffset:CGPointMake(splitCollectionView.frame.size.width * (_selectedIndexPath.row / FoursplitNumber), 0)];
            transformOneTag = NO;
            break;
        }
        case NineSplitNumber:
        {
            [splitCollectionView setCollectionViewLayout:nineSplitFlowLayout animated:YES];
            [splitCollectionView setContentOffset:CGPointMake(splitCollectionView.frame.size.width * (_selectedIndexPath.row / NineSplitNumber), 0) animated:YES];
            transformOneTag = NO;
            break;
        }
        case SixteenSplitNumber:
        {
            [splitCollectionView setCollectionViewLayout:sixteenSplitFlowLayout animated:YES];
            transformOneTag = NO;
            break;
        }
            
        default:
            break;
    }
    _previousSplitNumber = _nowSplitNumber;
    _nowSplitNumber = splitnumber;
    if (_delegate && [_delegate respondsToSelector:@selector(collectionView:splitFlowLayoutChangeWithSplitNumber:)])
    {
        [_delegate collectionView:self splitFlowLayoutChangeWithSplitNumber:splitnumber];
    }
}

#pragma mark - MultiSplitCollectionViewCell Delegate
-(void)didDoubleTapCell
{
    if (_nowSplitNumber == OneSplitNumber)
    {
        [self changeSplitFlowLayout:_previousSplitNumber];
    }
    else
    {
        [self changeSplitFlowLayout:OneSplitNumber];
    }
}


#pragma mark - Cell amplify and condense
-(void)amplifyChosenCell
{
    
}

-(void)condenseChosenCell
{
    
}

-(void)setReloadData
{
    [splitCollectionView reloadData];
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
