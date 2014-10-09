//
//  CoreDataTestViewController.h
//  TestProject
//
//  Created by SSPC139 on 2014/10/9.
//  Copyright (c) 2014年 shinsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainAppDelegate.h"
#import "Country.h"

@interface CoreDataTestViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *CoreDataTableView;
@property (strong, nonatomic) IBOutlet UITextField *numberTextField;
@property (strong, nonatomic) IBOutlet UITextField *countryTextField;
@property (strong, nonatomic) NSString* testString;
- (IBAction)addButtonAction:(id)sender;
- (IBAction)readButtonAction:(id)sender;
- (IBAction)deleteButtonAction:(id)sender;


//@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
//@property (strong, nonatomic) NSManagedObjectModel *managedObjectModel;
//@property (strong, nonatomic) NSPersistentStoreCoordinator *persisteneCoordinator;

//-(NSURL *)applicationDocumentsDirectory;
//-(void)saveContext;

@end
