//
//  Country.h
//  TestProject
//
//  Created by SSPC139 on 2014/10/9.
//  Copyright (c) 2014年 shinsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Country : NSManagedObject

@property (nonatomic, retain) NSString * pk;
@property (nonatomic, retain) NSString * name;

@end
