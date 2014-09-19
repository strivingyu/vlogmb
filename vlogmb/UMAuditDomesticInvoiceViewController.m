//
//  UMAuditDomesticInvoiceViewController.m
//  vlogmb
//
//  Created by 余少勇 on 14-9-18.
//  Copyright (c) 2014年 you-meng.com. All rights reserved.
//

#import "UMAuditDomesticInvoiceViewController.h"
#import "UMAppDelegate.h"
#import "AFNetworking.h"
#import "DXAlertView.h"

@interface UMAuditDomesticInvoiceViewController ()

@end

@implementation UMAuditDomesticInvoiceViewController

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
     [self getDomesticInvoiceByWorknoAndDenominated];
}
-(void) getDomesticInvoiceByWorknoAndDenominated
{
    NSString *string=[[[[[UMAppDelegate basePath] stringByAppendingString:@"airorderInvoiceAction!getByWorknoAndDenominated.action?workno="] stringByAppendingString:self.workno] stringByAppendingString:@"&denominated="] stringByAppendingString:[self.denominated stringValue]];
    NSURL *url=[NSURL URLWithString:string];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation=[[AFHTTPRequestOperation alloc]initWithRequest:request];
    // operation.responseSerializer=[AFJSONResponseSerializer serializer];
    operation.responseSerializer=[AFHTTPResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError *error;
        NSData *responseData=(NSData *)responseObject;
        NSArray *json=[NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
        id airorderInvoice=[json objectAtIndex:0];
        self.tfWorkno.text=[airorderInvoice objectForKey:@"workno"];
        self.tfTitle.text=[airorderInvoice objectForKey:@"title"];
        self.tvDetail.text=[airorderInvoice objectForKey:@"detail"];
        self.tvOthers.text=[airorderInvoice objectForKey:@"memo"];
        self.serialno=[airorderInvoice objectForKey:@"serialno"];
        
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
    
    DXAlertView *alert = [[DXAlertView alloc] initWithTitle:@"提示信息" contentText:@"确定通过审核？" leftButtonTitle:@"确定" rightButtonTitle:@"取消"];
    [alert show];
    alert.leftBlock = ^() {
        NSString *string;
        if([self.memo isEqualToString:@"bizdomestic"])
        {
            string=[[[[[UMAppDelegate basePath] stringByAppendingString:@"airorderInvoiceAction!bizPass.action?serialno="] stringByAppendingString:self.serialno] stringByAppendingString:@"&type="] stringByAppendingString:self.memo];
        }
        else
        {
            UMAppDelegate *app=(UMAppDelegate *)[UIApplication sharedApplication].delegate;
            NSNumber *accountid= app.accountid;
            string=[[[[[[[UMAppDelegate basePath] stringByAppendingString:@"airorderInvoiceAction!finPass.action?serialno="] stringByAppendingString:self.serialno] stringByAppendingString:@"&type="] stringByAppendingString:self.memo] stringByAppendingString:@"&accountid="] stringByAppendingString:[accountid stringValue]];
        }
        NSURL *url=[NSURL URLWithString:string];
        NSURLRequest *request=[NSURLRequest requestWithURL:url];
        
        AFHTTPRequestOperation *operation=[[AFHTTPRequestOperation alloc]initWithRequest:request];
        // operation.responseSerializer=[AFJSONResponseSerializer serializer];
        operation.responseSerializer=[AFHTTPResponseSerializer serializer];
        
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            UIAlertView *alertView=[[UIAlertView alloc] initWithTitle: @"提示信息" message:@"操作成功"delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alertView show];
            [self.navigationController popViewControllerAnimated:YES];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            UIAlertView *alertView=[[UIAlertView alloc] initWithTitle: @"提示信息" message:@"网络不通"delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alertView show];
        }];
        
        [operation start];
    };
    alert.rightBlock = ^() {
       // NSLog(@"right button clicked");
    };
    alert.dismissBlock = ^() {
      //  NSLog(@"Do something interesting after dismiss block");
    };
    
    
    
}

- (IBAction)refuse:(id)sender {
    
    DXAlertView *alert = [[DXAlertView alloc] initWithTitle:@"提示信息" contentText:@"确定退回？" leftButtonTitle:@"确定" rightButtonTitle:@"取消"];
    [alert show];
    alert.leftBlock = ^() {
        NSString *string;
        if([self.memo isEqualToString:@"bizdomestic"])
        {
            string=[[[[[UMAppDelegate basePath] stringByAppendingString:@"airorderInvoiceAction!bizRefuse.action?serialno="] stringByAppendingString:self.serialno] stringByAppendingString:@"&type="] stringByAppendingString:self.memo];
        }
        else
        {
            UMAppDelegate *app=(UMAppDelegate *)[UIApplication sharedApplication].delegate;
            NSNumber *accountid= app.accountid;
            string=[[[[[[[UMAppDelegate basePath] stringByAppendingString:@"airorderInvoiceAction!finRefuse.action?serialno="] stringByAppendingString:self.serialno] stringByAppendingString:@"&type="] stringByAppendingString:self.memo] stringByAppendingString:@"&accountid="] stringByAppendingString:[accountid stringValue]];
        }
        NSURL *url=[NSURL URLWithString:string];
        NSURLRequest *request=[NSURLRequest requestWithURL:url];
        
        AFHTTPRequestOperation *operation=[[AFHTTPRequestOperation alloc]initWithRequest:request];
        // operation.responseSerializer=[AFJSONResponseSerializer serializer];
        operation.responseSerializer=[AFHTTPResponseSerializer serializer];
        
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            UIAlertView *alertView=[[UIAlertView alloc] initWithTitle: @"提示信息" message:@"操作成功"delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alertView show];
            [self.navigationController popViewControllerAnimated:YES];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            UIAlertView *alertView=[[UIAlertView alloc] initWithTitle: @"提示信息" message:@"网络不通"delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alertView show];
        }];
        
        [operation start];
    };
    alert.rightBlock = ^() {
        // NSLog(@"right button clicked");
    };
    alert.dismissBlock = ^() {
        //  NSLog(@"Do something interesting after dismiss block");
    };
    

}
@end
