//
//  GWHttpMethods.h
//  MyCam
//
//  Created by SSPC139 on 2014/11/6.
//  Copyright (c) 2014年 shinsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum {
    GWHttpMethodGet,
    GWHttpMethodPost,
} GWHttpMethodsType;

@class GWHttpMethods;

@protocol GWHttpMethodsDelegate <NSObject>
@required
- (void) connFailed:(GWHttpMethods *)connect WithError:(NSError *)error;
@optional
- (void) postResult:(GWHttpMethods *)connect result:(NSData *) data;
- (void) getResult:(GWHttpMethods *)connect result:(NSData *) data;
@end

@interface GWHttpMethods : NSObject <NSURLConnectionDataDelegate, NSURLConnectionDelegate>


// GWHttpMehods properties
@property (nonatomic, readonly) GWHttpMethodsType httpMethodType;
@property (nonatomic, strong) id <GWHttpMethodsDelegate> delegate;

// GWHttpMethods functions
-(instancetype)initWithDelegate:(id)delegate andHttpMethodType:(GWHttpMethodsType)httpMethodType;
-(void)sendHttpGetWithURLString:(NSString *)urlString andKeys:(NSArray *)keysArray andValues:(NSArray *)valuesArray;
-(void)sendHttpPostWithURLString:(NSString *)urlString andKeys:(NSArray *)keysArray andValues:(NSArray *)valuesArray;
@end
