//
//  MultiSplitCollectionViewCell.m
//  TestProject
//
//  Created by shinsoft on 2014/5/30.
//  Copyright (c) 2014年 Goston. All rights reserved.
//

#import "MultiSplitCollectionViewCell.h"

@implementation MultiSplitCollectionViewCell
{
    UILabel *numberLabel;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
//        [self.layer setBorderColor:[UIColor whiteColor].CGColor];
//        [self.layer setBorderWidth:1.f];
        // Make sure cell is not in full screen mode
        [self setBackgroundColor:[UIColor greenColor]];
        [self.contentView setBackgroundColor:[UIColor orangeColor]];
        [self.contentView.layer setBorderColor:[UIColor blueColor].CGColor];
        [self.contentView.layer setBorderWidth:1.f];
        
        numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 30, 20)];
        [numberLabel setTextColor:[UIColor purpleColor]];
        [self addSubview:numberLabel];
    }
    return self;
}

-(void)setDelegate:(id<MultiSplitCollectionViewCellDelegate>)delegate
{
    _delegate = delegate;
    UITapGestureRecognizer *tapTwiceOneSplit = [[UITapGestureRecognizer alloc] initWithTarget:_delegate action:@selector(didDoubleTapCell)];
    [tapTwiceOneSplit setNumberOfTapsRequired:2];
    [tapTwiceOneSplit setCancelsTouchesInView:NO];
    [self addGestureRecognizer:tapTwiceOneSplit];
}

-(void)setIndexPath:(NSIndexPath *)indexPath
{
    _indexPath = indexPath;
    [numberLabel setText:[NSString stringWithFormat:@"%ld", indexPath.row]];
}

#pragma mark - Cell Transform to Parallelogram
-(void)cellTransformParallelogram
{
    
}

#pragma mark - Override UICollectionViewCell functions
-(void)willTransitionFromLayout:(UICollectionViewLayout *)oldLayout toLayout:(UICollectionViewLayout *)newLayout
{
    
}

-(void)didTransitionFromLayout:(UICollectionViewLayout *)oldLayout toLayout:(UICollectionViewLayout *)newLayout
{
    
}

#pragma mark - UITapGestureRecognizer Action
-(void)cellAmplifyorCondense:(UITapGestureRecognizer *)recognizer
{
    if (self.tag == 0)
    {
        self.tag = 1;
        [self amplifyChosenCell];
    }
    else
    {
        self.tag = 0;
        [self condenseChosenCell];
    }
}

// Amplify Cell in full screen mode
-(void)amplifyChosenCell
{
    
}

// Condense Cell in normal screen mode
-(void)condenseChosenCell
{
    
}

// When chosen cell be chosen other cell condense to background
-(void)condenseToBackground
{
    
}

// When chosen cell transform from full screen mode to normal screen mode other cell amplify to foreground
-(void)amplifyToForeground
{
    
}

//-(void)didDoubleTapCell:(UITapGestureRecognizer *)sender
//{
//    
//}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
