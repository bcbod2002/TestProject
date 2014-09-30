//
//  AppNotificationMessage.h
//  TestProject
//
//  Created by shinsoft on 2014/6/26.
//  Copyright (c) 2014年 Goston. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AppNotificationMessage;
@protocol AppNotificationMessageDelegate <NSObject>
@optional
-(void)notificationdidTapped;
@end

@interface AppNotificationMessage : UIView <UIGestureRecognizerDelegate>

@property (strong, nonatomic) id <AppNotificationMessageDelegate> delegate;

-(id)initWithMessageTitle:(NSString *)title;
-(void)perspectiveAppear;
-(void)perspectiveDisappear;

-(void)circleAppear;
-(void)circleMaskwithOtherMask;

@end
