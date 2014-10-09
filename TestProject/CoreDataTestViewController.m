//
//  CoreDataTestViewController.m
//  TestProject
//
//  Created by SSPC139 on 2014/10/9.
//  Copyright (c) 2014年 Goston. All rights reserved.
//

#import "CoreDataTestViewController.h"

@interface CoreDataTestViewController ()
{
    MainAppDelegate *appDelegate;
    NSArray *data;
}
@end

@implementation CoreDataTestViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    appDelegate = (MainAppDelegate *)[[UIApplication sharedApplication] delegate];
    data = [[NSArray alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return data.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CoreDataCell"];
    Country *tmpCountry = data[indexPath.row];
    [cell.textLabel setText:tmpCountry.name];
    return cell;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)addButtonAction:(id)sender
{
        NSLog(@"準備寫資料進入資料庫");
        Country *country =(Country*)[NSEntityDescription insertNewObjectForEntityForName:@"Country" inManagedObjectContext:[appDelegate managedObjectContext]];
        country.pk = _numberTextField.text;
        country.name = _countryTextField.text;
        NSError* error = nil;
        if(![appDelegate.m_managedObjectContext save:&error]){
            NSLog(@"新增資料遇到錯誤");
        }
}

- (IBAction)readButtonAction:(id)sender
{
    NSFetchRequest *fetch = [[NSFetchRequest alloc]init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Country" inManagedObjectContext:appDelegate.managedObjectContext];
    [fetch setEntity:entity];
    data = [appDelegate.managedObjectContext executeFetchRequest:fetch error:nil];
    [_CoreDataTableView reloadData];
//    NSLog(@"data = %@", data);
    NSLog(@"讀取資料庫完畢");

}

- (IBAction)deleteButtonAction:(id)sender
{
    NSManagedObjectContext *context = appDelegate.m_managedObjectContext;
    [context deleteObject:data[1]];
    
    NSError *error = nil;
    if (![context save:&error])
    {
        NSLog(@"刪除資料失敗 = %@", error);
    }
}

-(NSString *)getTestString
{
    return _testString;
}
@end
