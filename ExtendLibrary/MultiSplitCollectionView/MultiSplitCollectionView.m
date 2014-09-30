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
        
//        splitCollectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:fourSplitFlowLayout];
        splitCollectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:fourSplitFlowLayout];
         [splitCollectionView registerClass:[MultiSplitCollectionViewCell class] forCellWithReuseIdentifier:@"collectionViewCell"];
        splitCollectionView.delegate = self;
        splitCollectionView.dataSource = self;
        [splitCollectionView setPagingEnabled:YES];
        [self addSubview:splitCollectionView];
        transformOneTag = NO;
        NSLog(@"444");
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
    return _previousSplitNumber;
//    return 8;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MultiSplitCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionViewCell" forIndexPath:indexPath];
    UITapGestureRecognizer *tapTwiceOneSplit = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(transformIntoOneFlowLayout:)];
    [tapTwiceOneSplit setNumberOfTapsRequired:2];
    [cell addGestureRecognizer:tapTwiceOneSplit];
    NSLog(@"what what");
    return cell;
}

#pragma mark - UICollectionView Delegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [[collectionView cellForItemAtIndexPath:indexPath].layer setBorderColor:[UIColor redColor].CGColor];
    NSLog(@"indexPath = %ld", indexPath.row);
}

-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [[collectionView cellForItemAtIndexPath:indexPath].layer setBorderColor:[UIColor whiteColor].CGColor];
}



-(void)extendCollectionCellWithSplitNumber:(NSInteger)splitNumber
{
    
}

-(void)shrinkCollectionCell
{
    
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
            transformOneTag = NO;
            break;
        }
        case NineSplitNumber:
        {
            [splitCollectionView setCollectionViewLayout:nineSplitFlowLayout animated:YES];
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
    _previousSplitNumber = splitnumber;
    if (_delegate && [_delegate respondsToSelector:@selector(splitFlowLayoutChangeFinished)])
    {
        [_delegate splitFlowLayoutChangeFinished];
    }
}

-(void)transformIntoOneFlowLayout:(UITapGestureRecognizer *)gesture
{
    if (transformOneTag)
    {
        switch (_previousSplitNumber)
        {
            case OneSplitNumber:
            {
                [splitCollectionView setCollectionViewLayout:oneSplitFlowLayout animated:YES];
                break;
            }
            case FoursplitNumber:
            {
                [splitCollectionView setCollectionViewLayout:fourSplitFlowLayout animated:YES];
                break;
            }
            case NineSplitNumber:
            {
                [splitCollectionView setCollectionViewLayout:nineSplitFlowLayout animated:YES];
                break;
            }
            case SixteenSplitNumber:
            {
                [splitCollectionView setCollectionViewLayout:sixteenSplitFlowLayout animated:YES];
                break;
            }
                
            default:
                break;
        }
        transformOneTag = NO;
    }
    else
    {
        CGPoint initialDoubleTapPoint = [gesture locationInView:splitCollectionView];
        NSIndexPath *doubleTappedCellIndexPath = [splitCollectionView indexPathForItemAtPoint:initialDoubleTapPoint];
        [splitCollectionView setCollectionViewLayout:[[OneSplitFlowLayout alloc] init] animated:YES];
        [splitCollectionView setContentOffset:CGPointMake(320 * doubleTappedCellIndexPath.row, 0) animated:YES];
        transformOneTag = YES;
    }
}


#pragma mark - Cell amplify and condense
-(void)amplifyChosenCell
{
    
}

-(void)condenseChosenCell
{
    
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
