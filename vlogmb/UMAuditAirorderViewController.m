//
//  UMAuditAirorderViewController.m
//  vlogmb
//
//  Created by 余少勇 on 14-9-18.
//  Copyright (c) 2014年 you-meng.com. All rights reserved.
//

#import "UMAuditAirorderViewController.h"
#import "UMAppDelegate.h"
#import "AFNetworking.h"
#import "DXAlertView.h"
@interface UMAuditAirorderViewController ()

@end

@implementation UMAuditAirorderViewController

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
    [self getAirorderByWorkno];
}

-(void) getAirorderByWorkno
{
   NSString *string=[[[UMAppDelegate basePath] stringByAppendingString:@"airorderAction!getByWorkno.action?workno="] stringByAppendingString:self.workno];
    NSURL *url=[NSURL URLWithString:string];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation=[[AFHTTPRequestOperation alloc]initWithRequest:request];
    // operation.responseSerializer=[AFJSONResponseSerializer serializer];
    operation.responseSerializer=[AFHTTPResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError *error;
        NSData *responseData=(NSData *)responseObject;
        NSArray *json=[NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
        id airorder=[json objectAtIndex:0];
        self.dfShipper.text=[airorder objectForKey:@"shipper"];
        self.dfConsignee.text=[airorder objectForKey:@"consignee"];
        self.dfDelegateDate.text=[airorder objectForKey:@"delegatedate"];
        self.dfDeparturePort.text=[airorder objectForKey:@"departureport"];
        self.dfDestinationPort.text=[airorder objectForKey:@"destinationport"];
        self.dfGoodsDescription.text=[airorder objectForKey:@"goodsdescription"];
        self.dfMarks.text=[airorder objectForKey:@"marknumbers"];
        self.dfNotifyParty.text=[airorder objectForKey:@"marknumbers"];
        self.dfSender.text=[airorder objectForKey:@"sender"];
        self.dfTotalGoodsno.text=[airorder objectForKey:@"totalgoodsno"];
        self.dfTotalWeight.text=[airorder objectForKey:@"totalweight"];
        self.dfVolume.text=[airorder objectForKey:@"volume"];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle: @"提示信息" message:@"网络不通"delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
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

- (IBAction)pass:(id)sender {
    
}

- (IBAction)refuse:(id)sender {
   }
@end
