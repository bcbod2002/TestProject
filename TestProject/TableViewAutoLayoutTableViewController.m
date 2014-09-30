//
//  TableViewAutoLayoutTableViewController.m
//  TestProject
//
//  Created by shinsoft on 2014/3/21.
//  Copyright (c) 2014年 Goston. All rights reserved.
//

#import "TableViewAutoLayoutTableViewController.h"

@interface TableViewAutoLayoutTableViewController ()

@end

@implementation TableViewAutoLayoutTableViewController
{
    NSMutableArray *autoLayoutArray;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"TableViewController AutoLayout");
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    autoLayoutArray = [[NSMutableArray alloc] initWithObjects:@"Tittle indexPath 0",@"Tittle indexPath 1", @"Tittle indexPath 2", @"Tittle indexPath 3", @"Tittle indexPath 4", @"Tittle indexPath 5", nil];
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    UITapGestureRecognizer *taptableView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapCancelediting:)];
    [self.view addGestureRecognizer:taptableView];
}

-(void)tapCancelediting:(id)sender
{
    [self setEditing:NO animated:NO];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [autoLayoutArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"autoLayout" forIndexPath:indexPath];
    
    // Configure the cell...
    [cell setUserInteractionEnabled:YES];
    cell.detailTextLabel.text = [@"Description indexPath " stringByAppendingString:[NSString stringWithFormat:@"%d", indexPath.row]];
//    cell.textLabel.text = [@"Tittle indexPath" stringByAppendingString:[NSString stringWithFormat:@"%d", indexPath.row]];
    cell.textLabel.text = [autoLayoutArray objectAtIndex:indexPath.row];
    
    UILongPressGestureRecognizer *cellLongPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(cellLongPress:)];
    [cellLongPress setMinimumPressDuration:1];
    [cell addGestureRecognizer:cellLongPress];
    
    return cell;
}

-(void)cellLongPress:(id)sender
{
    [self setEditing:YES animated:YES];
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleNone;
}

// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    NSLog(@"Move Row");
    id object = [autoLayoutArray objectAtIndex:fromIndexPath.row];
    [autoLayoutArray removeObjectAtIndex:fromIndexPath.row];
    [autoLayoutArray insertObject:object atIndex:toIndexPath.row];
}



// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

@end
