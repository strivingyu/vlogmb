//
//  UMTodayBizViewController.m
//  vlogmb
//
//  Created by 余少勇 on 14-9-4.
//  Copyright (c) 2014年 you-meng.com. All rights reserved.
//

#import "UMTodayBizViewController.h"
#import "UMAppDelegate.h"
#import "AFNetworking.h"

@interface UMTodayBizViewController ()

@end

@implementation UMTodayBizViewController

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
    
    self.currentDate.text=dateString;
    [self getTotalOrderNumByDate:dateString];
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
-(void) getTotalOrderNumByDate:(NSString *)dateString
{
    UMAppDelegate *app=(UMAppDelegate *)[UIApplication sharedApplication].delegate;
    NSNumber *branchcompanyid= app.branchcompanyid;
    
    int year=[[dateString substringWithRange:NSMakeRange(0, 4)] intValue];
    int month=[[dateString substringWithRange:NSMakeRange(5, 2)] intValue];
    int day=[[dateString substringWithRange:NSMakeRange(8, 2)] intValue];
    NSString *string=[[[[[[[@"http://192.168.1.229:8080/vlogchinafreightsystem/airorderAction!countNewOrderByDay.action?branchcompanyid=" stringByAppendingString:[branchcompanyid stringValue]] stringByAppendingString:@"&year="] stringByAppendingString:[NSString stringWithFormat:@"%d",year]] stringByAppendingString:@"&month="] stringByAppendingString:[NSString stringWithFormat:@"%d",month]] stringByAppendingString:@"&day="] stringByAppendingString:[NSString stringWithFormat:@"%d",day]];
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
- (IBAction)previousDay:(id)sender {
    
    NSCalendar *calendar=[NSCalendar currentCalendar];
    NSDateComponents *comps;
    comps=[calendar components:(NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit) fromDate:[[NSDate alloc] init]];
    [comps setHour:-24];
    [comps setMinute:0];
    [comps setSecond:0];
    NSDate *nowDate=[calendar dateByAddingComponents:comps toDate:currentDate options:0];
    
    currentDate=nowDate;
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    dateString=[formatter stringFromDate:nowDate];
    
    self.currentDate.text=dateString;
    [self getTotalOrderNumByDate:dateString];
    
}

- (IBAction)nextDay:(id)sender {
    
    NSCalendar *calendar=[NSCalendar currentCalendar];
    NSDateComponents *comps;
    comps=[calendar components:(NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit) fromDate:[[NSDate alloc] init]];
    [comps setHour:+24];
    [comps setMinute:0];
    [comps setSecond:0];
    NSDate *nowDate=[calendar dateByAddingComponents:comps toDate:currentDate options:0];
    
    currentDate=nowDate;
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    dateString=[formatter stringFromDate:nowDate];
    
    self.currentDate.text=dateString;
    [self getTotalOrderNumByDate:dateString];
}
@end
