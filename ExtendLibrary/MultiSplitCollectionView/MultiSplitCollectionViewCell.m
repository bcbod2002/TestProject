//
//  MultiSplitCollectionViewCell.m
//  TestProject
//
//  Created by shinsoft on 2014/5/30.
//  Copyright (c) 2014年 shinsoft. All rights reserved.
//

#import "MultiSplitCollectionViewCell.h"

@implementation MultiSplitCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self.layer setBorderColor:[UIColor whiteColor].CGColor];
        [self.layer setBorderWidth:1.f];
        [self setUserInteractionEnabled:YES];
        UITapGestureRecognizer *tapTwiceChosenCell = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cellAmplifyorCondense:)];
        [tapTwiceChosenCell setNumberOfTouchesRequired:2];
        [self addGestureRecognizer:tapTwiceChosenCell];
        NSLog(@"YESYESYES");
        // Make sure cell is not in full screen mode
        self.tag = 0;
    }
    return self;
}

#pragma mark - Cell Transform to Parallelogram
-(void)cellTransformParallelogram
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


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
