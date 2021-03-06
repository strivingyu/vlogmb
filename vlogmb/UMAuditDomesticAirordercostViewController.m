//
//  UMAuditDomesticAirordercostViewController.m
//  vlogmb
//
//  Created by 余少勇 on 14-9-18.
//  Copyright (c) 2014年 you-meng.com. All rights reserved.
//

#import "UMAuditDomesticAirordercostViewController.h"
#import "ASFTableView.h"
#import "UMAppDelegate.h"
#import "AFNetworking.h"
#import "DXAlertView.h"
@interface UMAuditDomesticAirordercostViewController ()
@property (nonatomic, retain) NSMutableArray *rowsArray;
@end

@implementation UMAuditDomesticAirordercostViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (id)initWithCoder:(NSCoder*)aDecoder
{
    if(self = [super initWithCoder:aDecoder])
    {
        _rowsArray = [[NSMutableArray alloc] init];
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self listDomesticByWorkno];
}
-(void) listDomesticByWorkno
{
    NSString *string=[[[UMAppDelegate basePath] stringByAppendingString:@"airorderCostAction!listDomesticByWorkno.action?workno="] stringByAppendingString:self.workno];
    
    NSURL *url=[NSURL URLWithString:string];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation=[[AFHTTPRequestOperation alloc]initWithRequest:request];
    // operation.responseSerializer=[AFJSONResponseSerializer serializer];
    operation.responseSerializer=[AFHTTPResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError *error;
        NSData *responseData=(NSData *)responseObject;
        
        NSArray *json=[NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
        
        NSArray *cols = @[@"类型",@"收费项目",@"结算单位",@"币种",@"金额"];
        NSArray *weights = @[@(0.22f),@(0.22f),@(0.36f),@(0.09f),@(0.13f)];
        NSDictionary *options = @{kASF_OPTION_CELL_TEXT_FONT_SIZE : @(8),
                                  kASF_OPTION_CELL_TEXT_FONT_BOLD : @(true),
                                  kASF_OPTION_CELL_BORDER_COLOR : [UIColor lightGrayColor],
                                  kASF_OPTION_CELL_BORDER_SIZE : @(2.0),
                                  kASF_OPTION_BACKGROUND : [UIColor colorWithRed:239/255.0 green:244/255.0 blue:254/255.0 alpha:1.0]};
        
        [_mASFTableView setDelegate:self];
        [_mASFTableView setBounces:NO];
        [_mASFTableView setSelectionColor:[UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0f]];
        [_mASFTableView setTitles:cols
                      WithWeights:weights
                      WithOptions:options
                        WitHeight:12 Floating:NO];
        
        [_rowsArray removeAllObjects];
        for(int i=0;i<[json count];i++)
        {
            NSDictionary *airorderCost=[json objectAtIndex:i];
            
            [_rowsArray addObject:@{
                                    kASF_ROW_ID :
                                        @(i),
                                    
                                    kASF_ROW_CELLS :
                                        @[@{kASF_CELL_TITLE :[airorderCost objectForKey:@"type"], kASF_OPTION_CELL_TEXT_ALIGNMENT : @(NSTextAlignmentLeft)},
                                          @{kASF_CELL_TITLE : [airorderCost objectForKey:@"costitem"], kASF_OPTION_CELL_TEXT_ALIGNMENT : @(NSTextAlignmentLeft)},
                                          @{kASF_CELL_TITLE : [airorderCost objectForKey:@"denominatedname"], kASF_OPTION_CELL_TEXT_ALIGNMENT : @(NSTextAlignmentLeft)},
                                          @{kASF_CELL_TITLE : [airorderCost objectForKey:@"currency"], kASF_OPTION_CELL_TEXT_ALIGNMENT : @(NSTextAlignmentLeft)},
                                          @{kASF_CELL_TITLE : [airorderCost objectForKey:@"eamount"], kASF_OPTION_CELL_TEXT_ALIGNMENT : @(NSTextAlignmentLeft)}
                                          ],
                                    
                                    kASF_ROW_OPTIONS :
                                        @{kASF_OPTION_BACKGROUND : [UIColor whiteColor],
                                          kASF_OPTION_CELL_PADDING : @(5),
                                          kASF_OPTION_CELL_TEXT_FONT_SIZE:@(8),
                                          kASF_OPTION_CELL_BORDER_COLOR : [UIColor lightGrayColor]}}];
        }
        
        
        [_mASFTableView setRows:_rowsArray];
        
        
        
        
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
        
        UMAppDelegate *app=(UMAppDelegate *)[UIApplication sharedApplication].delegate;
        NSNumber *accountid=app.accountid;
        NSString *string=[[[[[UMAppDelegate basePath] stringByAppendingString:@"virtualTaskAction!tagAuditDomesticAirorderCostFinished.action?workno="] stringByAppendingString:self.workno] stringByAppendingString:@"&accountid="] stringByAppendingString:[accountid stringValue]];
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
        NSString *string=[[[[[UMAppDelegate basePath] stringByAppendingString:@"virtualTaskAction!tagAuditDomesticAirorderCostRefused.action?workno="] stringByAppendingString:self.workno] stringByAppendingString:@"&opinion="] stringByAppendingString:@"wrong cost"];
       
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
