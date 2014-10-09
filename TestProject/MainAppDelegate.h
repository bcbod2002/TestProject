//
//  MainAppDelegate.h
//  TestProject
//
//  Created by shinsoft on 2014/3/17.
//  Copyright (c) 2014年 Goston. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface MainAppDelegate : UIResponder <UIApplicationDelegate>
{
//    NSManagedObjectContext *m_managedObjectContext;
//    NSPersistentStoreCoordinator *m_persistentCoordinator;
//    NSManagedObjectModel *m_managedObjectModel;

}

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, retain) NSManagedObjectContext *m_managedObjectContext;
@property (nonatomic, retain) NSManagedObjectModel *m_managedObjectModel;
@property (nonatomic, retain) NSPersistentStoreCoordinator *m_persistentCoordinator;
//這是用來取得資料庫實體位置，Sqlite實體位置會被放置在這個路徑之下 ~/library/Application Support/iPhone Simulator/版本/Applications/你的App/Documents/
-(NSURL *)applicationDocumentsDirectory;
//傳回這個APP的物件本文管理，用來作物件同步
-(NSManagedObjectContext*)managedObjectContext;
//傳回這個APP中管理資料庫的persistent store coordinator 物件
//Persistent Store Coordinator相當於資料文件管理器，處理底層的對資料文件的讀取與寫入。一般我們無需與它打交道。
-(NSPersistentStoreCoordinator *)persistentStoreCoordinator;
//傳回這個APP中
//Managed Object Model是描述應用程序的資料模型，這個模型包含實體（Entity），特性（Property），讀取請求（Fetch Request ）等。
-(NSManagedObjectModel*)managedObjectModel;



@end
