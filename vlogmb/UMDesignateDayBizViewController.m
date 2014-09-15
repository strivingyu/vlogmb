//
//  UMDesignateDayBizViewController.m
//  vlogmb
//
//  Created by 余少勇 on 14-9-4.
//  Copyright (c) 2014年 you-meng.com. All rights reserved.
//

#import "UMDesignateDayBizViewController.h"
#import "UMAppDelegate.h"
#import "AFNetworking.h"

@interface UMDesignateDayBizViewController ()

@end

@implementation UMDesignateDayBizViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (IBAction)getTotalOrderNum:(id)sender {
    
    NSDate *selectDate=[self.datePicker date];
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSString *dateString=[formatter stringFromDate:selectDate];
    [self getTotalOrderNumByDate:dateString];
}
-(void) getTotalOrderNumByDate:(NSString *)dateString
{
    UMAppDelegate *app=(UMAppDelegate *)[UIApplication sharedApplication].delegate;
    NSNumber *branchcompanyid= app.branchcompanyid;
    
    int year=[[dateString substringWithRange:NSMakeRange(0, 4)] intValue];
    int month=[[dateString substringWithRange:NSMakeRange(5, 2)] intValue];
    int day=[[dateString substringWithRange:NSMakeRange(8, 2)] intValue];
    NSString *string=[[[[[[[[[UMAppDelegate basePath] stringByAppendingString:@"airorderAction!countNewOrderByDay.action?branchcompanyid="] stringByAppendingString:[branchcompanyid stringValue]] stringByAppendingString:@"&year="] stringByAppendingString:[NSString stringWithFormat:@"%d",year]] stringByAppendingString:@"&month="] stringByAppendingString:[NSString stringWithFormat:@"%d",month]] stringByAppendingString:@"&day="] stringByAppendingString:[NSString stringWithFormat:@"%d",day]];
    NSURL *url=[NSURL URLWithString:string];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation=[[AFHTTPRequestOperation alloc]initWithRequest:request];
    // operation.responseSerializer=[AFJSONResponseSerializer serializer];
    operation.responseSerializer=[AFHTTPResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError *error;
        NSData *responseData=(NSData *)responseObject;
        NSDictionary *json=[NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
        NSString *numOfDayNewOrder=(NSString *)[json objectForKey:@"numOfDayNewOrder"];     //   NSString
        self.totalOrderNum.text=numOfDayNewOrder;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle: @"网络不通" message:@"网络不通"delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alertView show];
    }];
    
    [operation start];
}

@end
