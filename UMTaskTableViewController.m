//
//  UMTaskTableViewController.m
//  vlogmb
//
//  Created by 余少勇 on 14-9-17.
//  Copyright (c) 2014年 you-meng.com. All rights reserved.
//

#import "UMTaskTableViewController.h"
#import "UMAppDelegate.h"
#import "AFNetworking.h"
#import "UMTaskTableViewCell.h"

@interface UMTaskTableViewController ()
@end

@implementation UMTaskTableViewController

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
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self listTask];
}

-(void) listTask
{
    UMAppDelegate *app=(UMAppDelegate *)[UIApplication sharedApplication].delegate;
    NSNumber *accountid= app.accountid;
    
    NSString *string=[[[UMAppDelegate basePath] stringByAppendingString:@"virtualTaskAction!listMobileTaskByAccountid.action?accountid="] stringByAppendingString:[accountid stringValue]];
    NSURL *url=[NSURL URLWithString:string];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation=[[AFHTTPRequestOperation alloc]initWithRequest:request];
    // operation.responseSerializer=[AFJSONResponseSerializer serializer];
    operation.responseSerializer=[AFHTTPResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError *error;
        NSData *responseData=(NSData *)responseObject;
        self.taskList=[NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
        [self.tableView reloadData];
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle: @"提示信息" message:@"网络不通"delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alertView show];
    }];
    
    [operation start];}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.taskList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier=@"Cell";
   // NSString *string = nil;
  //  UMTaskTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleSubtitle
                reuseIdentifier: CellIdentifier];
    }
    // Configure the cell...
    int row=[indexPath row];
    cell.textLabel.text=[[self.taskList objectAtIndex:row] objectForKey:@"type"];
    cell.detailTextLabel.text=[[[[self.taskList objectAtIndex:row] objectForKey:@"workno"] stringByAppendingString:@"       "] stringByAppendingString:[[self.taskList objectAtIndex:row] objectForKey:@"time"]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}


//响应用户单击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *type;
    
    
    type = [[self.taskList objectAtIndex:indexPath.row] objectForKey:@"type"];
    self.workno = [[self.taskList objectAtIndex:indexPath.row] objectForKey:@"workno"];
    self.denominated=[[self.taskList objectAtIndex:indexPath.row] objectForKey:@"denominated"];
    self.memo=[[self.taskList objectAtIndex:indexPath.row] objectForKey:@"memo"];
    if ([type isEqualToString:@"空运下单审核"]) {
        [self performSegueWithIdentifier:@"AuditAirorder" sender:self];
    }
    else if([type isEqualToString:@"空运下单重审"])
    {
        [self performSegueWithIdentifier:@"AuditAirorder" sender:self];
    }
    else if([type isEqualToString:@"国内费用审核"])
    {
        [self performSegueWithIdentifier:@"AuditDomesticAirordercost" sender:self];
    }
    else if([type isEqualToString:@"国外费用审核"])
    {
        [self performSegueWithIdentifier:@"AuditForeignAirordercost" sender:self];
    }
    else if([type isEqualToString:@"国内开票审核"])
    {
        [self performSegueWithIdentifier:@"AuditDomesticInvoice" sender:self];    }
    else if([type isEqualToString:@"整单审核"])
    {
        [self performSegueWithIdentifier:@"AuditWholeAirorder" sender:self];    }

    else
    {
        
    }
    }


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
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
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
   
    UIViewController *view = segue.destinationViewController;
    [view setValue:self.workno forKey:@"workno"];
    [view setValue:self.denominated forKey:@"denominated"];
    [view setValue:self.memo forKey:@"memo"];
}


@end
