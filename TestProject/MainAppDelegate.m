//
//  MainAppDelegate.m
//  TestProject
//
//  Created by shinsoft on 2014/3/17.
//  Copyright (c) 2014年 Goston. All rights reserved.
//

#import "MainAppDelegate.h"

@implementation MainAppDelegate
//@synthesize m_managedObjectContext;
//@synthesize m_persistentCoordinator;
//@synthesize m_managedObjectModel;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
//    NSManagedObjectContext *context = [self managedObjectContext];
//    NSManagedObject *failedBankInfo = [NSEntityDescription
//                                       insertNewObjectForEntityForName:@"FailedBankInfo"
//                                       inManagedObjectContext:context];
//    [failedBankInfo setValue:@"Test Bank" forKey:@"name"];
//    [failedBankInfo setValue:@"Testville" forKey:@"city"];
//    [failedBankInfo setValue:@"Testland" forKey:@"state"];
//    NSManagedObject *failedBankDetails = [NSEntityDescription
//                                          insertNewObjectForEntityForName:@"FailedBankDetails"
//                                          inManagedObjectContext:context];
//    [failedBankDetails setValue:[NSDate date] forKey:@"closeDate"];
//    [failedBankDetails setValue:[NSDate date] forKey:@"updateDate"];
//    [failedBankDetails setValue:[NSNumber numberWithInt:12345] forKey:@"zip"];
//    [failedBankDetails setValue:failedBankInfo forKey:@"info"];
//    [failedBankInfo setValue:failedBankDetails forKey:@"details"];
//    NSError *error;
//    if (![context save:&error]) {
//        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
//    }
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(NSURL *)applicationDocumentsDirectory{
    return [[[NSFileManager defaultManager]URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask]lastObject];
}


-(NSManagedObjectContext *)managedObjectContext{
    if(_m_managedObjectContext != nil){
        return _m_managedObjectContext;
    }
    //在managedObjectContext裡面會對persistentStoreCoordinator發出資料庫操作的請求，所以在此可以看到這邊去建立了一個NSPersistentStoreCoordinator 實例
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if(coordinator != nil){
        _m_managedObjectContext = [[NSManagedObjectContext alloc] init];

        [_m_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _m_managedObjectContext;
}



-(NSPersistentStoreCoordinator *)persistentStoreCoordinator{
    if (_m_persistentCoordinator != nil){
        return _m_persistentCoordinator;
    }
    //指定實際存放資料庫的位置，這邊會呼叫applicationDocumentsDirectory方法取得資料庫的實體路徑
    NSURL *storeURL = [[self applicationDocumentsDirectory]URLByAppendingPathComponent:@"data.sqlite"];
    NSError *error = nil;
    //呼叫managedObjectModel，經由managedObjectModel讀取資料模型來生成被管理的物件Managed object
    _m_persistentCoordinator = [[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:[self managedObjectModel]];
    if(![_m_persistentCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]){
        NSLog(@"讀取資料時發生錯誤 %@,%@",error,[error userInfo]);
        abort();
    }
    return _m_persistentCoordinator;

}


-(NSManagedObjectModel *)managedObjectModel{
    if(_m_managedObjectModel != nil){
        return _m_managedObjectModel;
    }
    //讀取資料模型來生成被管理的物件Managedobject
    NSURL *modelURL = [[NSBundle mainBundle]URLForResource:@"country" withExtension:@"momd"];
    _m_managedObjectModel = [[NSManagedObjectModel alloc]initWithContentsOfURL:modelURL];
    return _m_managedObjectModel;
}

@end
