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
#import "PNLineChartView.h"
#import "PNPlot.h"

@interface UMCurrentMonthBizViewController ()

@property (weak, nonatomic) IBOutlet PNLineChartView *lineChartView;
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
    
    if (_dateString==nil) {
        //获取当前日期
        NSDate *today=[NSDate date];
        currentDate=today;
        NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"YYYY-MM-dd"];
        _dateString=[formatter stringFromDate:today];
    }
    
    self.month.text=[[_dateString substringWithRange:NSMakeRange(5, 2)] stringByAppendingString:@"月"];
    [self getTotalOrderNumByMonth:_dateString];
    [self listAirorderNumByMonth:_dateString];
    
    
    }

-(void) getTotalOrderNumByMonth:(NSString *)dateString
{
    UMAppDelegate *app=(UMAppDelegate *)[UIApplication sharedApplication].delegate;
    NSNumber *branchcompanyid= app.branchcompanyid;
    
    int year=[[dateString substringWithRange:NSMakeRange(0, 4)] intValue];
    int month=[[dateString substringWithRange:NSMakeRange(5, 2)] intValue];
    NSString *string=[[[[[[[UMAppDelegate basePath] stringByAppendingString:@"airorderAction!countNewOrderByMonth.action?branchcompanyid="] stringByAppendingString:[branchcompanyid stringValue]] stringByAppendingString:@"&year="] stringByAppendingString:[NSString stringWithFormat:@"%d",year]] stringByAppendingString:@"&month="] stringByAppendingString:[NSString stringWithFormat:@"%d",month]];
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

-(void) listAirorderNumByMonth:(NSString *)dateString
{
    UMAppDelegate *app=(UMAppDelegate *)[UIApplication sharedApplication].delegate;
    NSNumber *branchcompanyid= app.branchcompanyid;
    
    int year=[[dateString substringWithRange:NSMakeRange(0, 4)] intValue];
    int month=[[dateString substringWithRange:NSMakeRange(5, 2)] intValue];
    NSString *string=[[[[[[[UMAppDelegate basePath] stringByAppendingString:@"airorderAction!listAirorderNumByMonth.action?branchcompanyid="] stringByAppendingString:[branchcompanyid stringValue]] stringByAppendingString:@"&year="] stringByAppendingString:[NSString stringWithFormat:@"%d",year]] stringByAppendingString:@"&month="] stringByAppendingString:[NSString stringWithFormat:@"%d",month]];
    NSURL *url=[NSURL URLWithString:string];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation=[[AFHTTPRequestOperation alloc]initWithRequest:request];
    // operation.responseSerializer=[AFJSONResponseSerializer serializer];
    operation.responseSerializer=[AFHTTPResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError *error;
        NSData *responseData=(NSData *)responseObject;
       
        NSArray *json=[NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
       
        NSMutableArray *dayArray=[[NSMutableArray alloc] init];
        NSMutableArray *numberArray=[[NSMutableArray alloc] init];
        
        for(int i=0;i<[json count];i++)
        {
            NSDictionary *one=[json objectAtIndex:i];
            
          
            [dayArray addObject:[one objectForKey:@"day"]];
            
            id temp=[one objectForKey:@"number"];
            NSNumber *num=temp;
            [numberArray addObject:num];
        }
        
        //显示图表
        // test line chart
        NSArray* plottingDataValues1 =numberArray;
  
        //获取numberArray的最大值和最小值
        int max=0;
        int min=0;
        
        for(int i=0;i<[numberArray count];i++)
        {
            id temp=[numberArray objectAtIndex:i];
            NSNumber *num=temp;
            if ([num intValue]>max) {
                max=[num intValue];
                if(min==0)
                {
                    min=max;
                }
            }
            else
            {
                if([num intValue]<min)
                {
                    min=[num intValue];
                }
            }
        }
        
        self.lineChartView.max = max;
        self.lineChartView.min = min;
        
        
        NSMutableArray* yAxisValues = [@[] mutableCopy];
        
        if(max-min<6)
        {
            self.lineChartView.interval = 1;
            for (int i=0; i<6; i++) {
                NSString* str = [NSString stringWithFormat:@"%d", i];
                [yAxisValues addObject:str];
            }
        }
        else
        {
            self.lineChartView.interval = (self.lineChartView.max-self.lineChartView.min)/5;
            for (int i=0; i<max-min; i++) {
                NSString* str = [NSString stringWithFormat:@"%.2f", self.lineChartView.min+self.lineChartView.interval*i];
                [yAxisValues addObject:str];
            }
        }
        
        self.lineChartView.xAxisValues = dayArray;
        self.lineChartView.yAxisValues = yAxisValues;
        self.lineChartView.axisLeftLineWidth = 39;
        
        
        PNPlot *plot1 = [[PNPlot alloc] init];
        plot1.plottingValues = plottingDataValues1;
        
        plot1.lineColor = [UIColor redColor];
        plot1.lineWidth = 1;
        [self.lineChartView clearPlot];
        [self.lineChartView addPlot:plot1];
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
    int year=[[_dateString substringWithRange:NSMakeRange(0, 4)] intValue];
    int month=[[_dateString substringWithRange:NSMakeRange(5, 2)] intValue];
    int day=[[_dateString substringWithRange:NSMakeRange(8, 2)] intValue];
    if(month==1) {
        year=year-1;
        month=12;
    }
    else
    {
        month=month-1;
    }
    
    NSString *monthStr;
    if(month>=10)
    {
        monthStr=[NSString stringWithFormat:@"%d",month];
    }
    else
    {
        monthStr=[@"0" stringByAppendingString:[NSString stringWithFormat:@"%d",month]];
    }
    NSString *dayStr;
    if(day>=10)
    {
        dayStr=[NSString stringWithFormat:@"%d",day];
    }
    else
    {
        dayStr=[@"0" stringByAppendingString:[NSString stringWithFormat:@"%d",day]];
    }
    
    
    _dateString=[[[[[NSString stringWithFormat:@"%d",year] stringByAppendingString:@"-"] stringByAppendingString:monthStr] stringByAppendingString:@"-"] stringByAppendingString:dayStr];
    
    
    self.month.text=[[_dateString substringWithRange:NSMakeRange(5, 2)] stringByAppendingString:@"月"];
    [self getTotalOrderNumByMonth:_dateString];
    [self listAirorderNumByMonth:_dateString];

}

- (IBAction)nextMonth:(id)sender {
    
    int year=[[_dateString substringWithRange:NSMakeRange(0, 4)] intValue];
    int month=[[_dateString substringWithRange:NSMakeRange(5, 2)] intValue];
    int day=[[_dateString substringWithRange:NSMakeRange(8, 2)] intValue];
    if(month==12) {
        year=year+1;
        month=1;
    }
    else
    {
        month=month+1;
    }
    
    NSString *monthStr;
    if(month>=10)
    {
        monthStr=[NSString stringWithFormat:@"%d",month];
    }
    else
    {
        monthStr=[@"0" stringByAppendingString:[NSString stringWithFormat:@"%d",month]];
    }
    NSString *dayStr;
    if(day>=10)
    {
        dayStr=[NSString stringWithFormat:@"%d",day];
    }
    else
    {
        dayStr=[@"0" stringByAppendingString:[NSString stringWithFormat:@"%d",day]];
    }
    
    
    _dateString=[[[[[NSString stringWithFormat:@"%d",year] stringByAppendingString:@"-"] stringByAppendingString:monthStr] stringByAppendingString:@"-"] stringByAppendingString:dayStr];
    
    
    self.month.text=[[_dateString substringWithRange:NSMakeRange(5, 2)] stringByAppendingString:@"月"];
    [self getTotalOrderNumByMonth:_dateString];
    [self listAirorderNumByMonth:_dateString];

}
@end
