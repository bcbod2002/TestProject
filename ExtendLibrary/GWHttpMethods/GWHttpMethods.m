//
//  GWHttpMethods.m
//  MyCam
//
//  Created by SSPC139 on 2014/11/6.
//  Copyright (c) 2014年 shinsoft. All rights reserved.
//

#import "GWHttpMethods.h"

@implementation GWHttpMethods
{
    NSString *domainName;
    NSString *webSite;
}


-(instancetype)initWithDelegate:(id)delegate andHttpMethodType:(GWHttpMethodsType)httpMethodType
{
    self = [super init];
    if (self)
    {
        _delegate = delegate;
        _httpMethodType = httpMethodType;
    }
    return self;
}

- (void)initDomain
{
    domainName = @"www.mycam.tw";
    webSite = @"http://%@/MyCam/app_service.jsp?fn=%@";
}

-(void)sendHttpGetWithURLString:(NSString *)urlString andKeys:(NSArray *)keysArray andValues:(NSArray *)valuesArray
{
    if (keysArray.count == valuesArray.count)
    {
        for (NSInteger i = 0; i < keysArray.count; ++i)
        {
            urlString = [urlString stringByAppendingFormat:@"&%@=%@", [keysArray objectAtIndex:i], [valuesArray objectAtIndex:i]];
        }
    }
    else
    {
        NSLog(@"Keys argumant and Values argumant are different");
    }
    NSLog(@"urlString = %@", urlString);
    dispatch_async(dispatch_get_main_queue(), ^{
        NSURL *httpGetURL = [NSURL URLWithString:urlString];
//        NSURL *httpGetURL = [NSURL URLWithString:@"http://video17.lax01.hls.twitch.tv/hls83/tsm_bjergsen_11770608176_163824162/chunked/py-index-live.m3u8?token=id=7499097341988482573,bid=11770608176,exp=1415957831,node=video17-1.lax01.hls.justin.tv,nname=video17.lax01,fmt=chunked&sig=7d69126f85bd39c8aab0313d30d3e6b6433f2e69"];
        NSMutableURLRequest *httpURLRequest = [[NSMutableURLRequest alloc] initWithURL:httpGetURL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:20.0];
        [httpURLRequest setHTTPMethod:@"GET"];
        NSURLConnection *httpURLConnection = [[NSURLConnection alloc] initWithRequest:httpURLRequest delegate:self startImmediately:YES];
        [httpURLConnection start];
    });
}

-(void)sendHttpPostWithURLString:(NSString *)urlString andKeys:(NSArray *)keysArray andValues:(NSArray *)valuesArray
{
    if (keysArray.count == valuesArray.count)
    {
        NSMutableDictionary *postBodyDictionary = [[NSMutableDictionary alloc] initWithObjects:keysArray forKeys:valuesArray];
        NSURL *httpPostURL = [NSURL URLWithString:urlString];
        NSError *jsonWriteError = nil;
        NSData *postBodyData = [NSJSONSerialization dataWithJSONObject:postBodyDictionary options:NSJSONWritingPrettyPrinted error:&jsonWriteError];
        NSString *postStringLength = [NSString stringWithFormat:@"%ld", (unsigned long)[postBodyData length]];
        NSMutableURLRequest *httpURLRequest = [[NSMutableURLRequest alloc] initWithURL:httpPostURL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:20.0];
        [httpURLRequest setHTTPMethod:@"POST"];
        [httpURLRequest setValue:postStringLength forHTTPHeaderField:@"Content-Length"];
        [httpURLRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [httpURLRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [httpURLRequest setHTTPBody:postBodyData];
        NSURLConnection *httpURLConnection = [[NSURLConnection alloc] initWithRequest:httpURLRequest delegate:self startImmediately:YES];
        [httpURLConnection start];
    }
}

#pragma mark - NSURLConnectionDataDelegate
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"Error = %@", [error localizedDescription]);
//    [_delegate connFailed:self WithError:error];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSLog(@"data = %@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    switch (_httpMethodType)
    {
        case GWHttpMethodGet:
        {
            [_delegate getResult:self result:data];
            break;
        }
            
        case GWHttpMethodPost:
        {
            [_delegate postResult:self result:data];
            break;
        }
            
        default:
            break;
    }
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
//    NSLog(@"connection response = %@", response.description);
}

-(void)connection:(NSURLConnection *)connection didSendBodyData:(NSInteger)bytesWritten totalBytesWritten:(NSInteger)totalBytesWritten totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite
{
//    NSLog(@"byteWritten = %ld", bytesWritten);
//    NSLog(@"totalBytesWritten = %ld", totalBytesWritten);
//    NSLog(@"totalBytesExpectedToWrite = %ld", totalBytesExpectedToWrite);
}
@end
