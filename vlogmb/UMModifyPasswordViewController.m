//
//  UMModifyPasswordViewController.m
//  vlogmb
//
//  Created by 余少勇 on 14-9-16.
//  Copyright (c) 2014年 you-meng.com. All rights reserved.
//

#import "UMModifyPasswordViewController.h"
#import "UMAppDelegate.h"
#import "AFNetworking.h"


@interface UMModifyPasswordViewController ()

@end

@implementation UMModifyPasswordViewController

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

- (IBAction)modify:(id)sender {
    
    UMAppDelegate *app=(UMAppDelegate *)[UIApplication sharedApplication].delegate;
    NSString *username=app.username;

    
    NSString *newPasswordStr=self.newerPassword.text;
    NSString *confirmPasswordStr=self.confirmPassword.text;
    if(![newPasswordStr  isEqualToString:confirmPasswordStr])
    {
        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle: @"提示信息" message:@"两次密码输入不一致" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alertView show];
    
    }
    else
    {
        NSString *string=[[[[[UMAppDelegate basePath] stringByAppendingString:@"accountAction!updatePassword.action?username="] stringByAppendingString:username]stringByAppendingString:@"&password="] stringByAppendingString:newPasswordStr];
        NSURL *url=[NSURL URLWithString:string];
        NSURLRequest *request=[NSURLRequest requestWithURL:url];
        
        AFHTTPRequestOperation *operation=[[AFHTTPRequestOperation alloc]initWithRequest:request];
        // operation.responseSerializer=[AFJSONResponseSerializer serializer];
        operation.responseSerializer=[AFHTTPResponseSerializer serializer];
        
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            UIAlertView *alertView=[[UIAlertView alloc] initWithTitle: @"提示信息" message:@"密码修改成功"delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alertView show];        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            UIAlertView *alertView=[[UIAlertView alloc] initWithTitle: @"网络不通" message:@"网络不通"delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alertView show];
        }];
        
        [operation start];
    }
}
@end
