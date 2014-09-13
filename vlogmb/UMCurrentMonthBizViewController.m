//
//  UMCurrentMonthBizViewController.m
//  vlogmb
//
//  Created by 余少勇 on 14-9-4.
//  Copyright (c) 2014年 you-meng.com. All rights reserved.
//

#import "UMCurrentMonthBizViewController.h"
#import "UMAppDelegate.h"
#import "AFNetworking.h"

@interface UMCurrentMonthBizViewController ()

@end

@implementation UMCurrentMonthBizViewController

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
    //获取当前日期
    NSDate *today=[NSDate date];
    currentDate=today;
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    dateString=[formatter stringFromDate:today];
    
    self.month.text=[[dateString substringWithRange:NSMakeRange(5, 2)] stringByAppendingString:@"月"];
    [self getTotalOrderNumByMonth:dateString];
}

-(void) getTotalOrderNumByMonth:(NSString *)dateString
{
    UMAppDelegate *app=(UMAppDelegate *)[UIApplication sharedApplication].delegate;
    NSNumber *branchcompanyid= app.branchcompanyid;
    
    int year=[[dateString substringWithRange:NSMakeRange(0, 4)] intValue];
    int month=[[dateString substringWithRange:NSMakeRange(5, 2)] intValue];
    NSString *string=[[[[[@"http://192.168.123.22:8080/vlogchinafreightsystem/airorderAction!countNewOrderByMonth.action?branchcompanyid=" stringByAppendingString:[branchcompanyid stringValue]] stringByAppendingString:@"&year="] stringByAppendingString:[NSString stringWithFormat:@"%d",year]] stringByAppendingString:@"&month="] stringByAppendingString:[NSString stringWithFormat:@"%d",month]];
    NSURL *url=[NSURL URLWithString:string];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation=[[AFHTTPRequestOperation alloc]initWithRequest:request];
    // operation.responseSerializer=[AFJSONResponseSerializer serializer];
    operation.responseSerializer=[AFHTTPResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError *error;
        NSData *responseData=(NSData *)responseObject;
        NSDictionary *json=[NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
        NSString *numOfMonthNewOrder=(NSString *)[json objectForKey:@"numOfMonthNewOrder"];     //   NSString
        self.totalOrderNum.text=numOfMonthNewOrder;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle: @"网络不通" message:@"网络不通"delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alertView show];
    }];
    
    [operation start];
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

- (IBAction)previousMonth:(id)sender {
    int year=[[dateString substringWithRange:NSMakeRange(0, 4)] intValue];
    int month=[[dateString substringWithRange:NSMakeRange(5, 2)] intValue];
    int day=[[dateString substringWithRange:NSMakeRange(8, 2)] intValue];
    if (month==1) {
        year=year-1;
        month=12;
    }
    else
    {
        month=month-1;
    }
    
    NSString *monthStr;
    if(month>10)
    {
        monthStr=[NSString stringWithFormat:@"%d",month];
    }
    else
    {
        monthStr=[@"0" stringByAppendingString:[NSString stringWithFormat:@"%d",month]];
    }
    NSString *dayStr;
    if(day>10)
    {
        dayStr=[NSString stringWithFormat:@"%d",day];
    }
    else
    {
        dayStr=[@"0" stringByAppendingString:[NSString stringWithFormat:@"%d",day]];
    }
    
    
    dateString=[[[[[NSString stringWithFormat:@"%d",year] stringByAppendingString:@"-"] stringByAppendingString:monthStr] stringByAppendingString:@"-"] stringByAppendingString:dayStr];
    
    
    self.month.text=[[dateString substringWithRange:NSMakeRange(5, 2)] stringByAppendingString:@"月"];
    [self getTotalOrderNumByMonth:dateString];}

- (IBAction)nextMonth:(id)sender {
    
    int year=[[dateString substringWithRange:NSMakeRange(0, 4)] intValue];
    int month=[[dateString substringWithRange:NSMakeRange(5, 2)] intValue];
    int day=[[dateString substringWithRange:NSMakeRange(8, 2)] intValue];
    if (month==12) {
        year=year+1;
        month=1;
    }
    else
    {
        month=month+1;
    }
    
    NSString *monthStr;
    if(month>10)
    {
        monthStr=[NSString stringWithFormat:@"%d",month];
    }
    else
    {
        monthStr=[@"0" stringByAppendingString:[NSString stringWithFormat:@"%d",month]];
    }
    NSString *dayStr;
    if(day>10)
    {
        dayStr=[NSString stringWithFormat:@"%d",day];
    }
    else
    {
        dayStr=[@"0" stringByAppendingString:[NSString stringWithFormat:@"%d",day]];
    }
    
    
    dateString=[[[[[NSString stringWithFormat:@"%d",year] stringByAppendingString:@"-"] stringByAppendingString:monthStr] stringByAppendingString:@"-"] stringByAppendingString:dayStr];
    
    
    self.month.text=[[dateString substringWithRange:NSMakeRange(5, 2)] stringByAppendingString:@"月"];
    [self getTotalOrderNumByMonth:dateString];}
}
@end
