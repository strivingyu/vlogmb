//
//  UMLoginViewController.m
//  vlogmb
//
//  Created by 余少勇 on 14-9-10.
//  Copyright (c) 2014年 you-meng.com. All rights reserved.
//

#import "UMLoginViewController.h"
#import "AFNetworking.h"

@interface UMLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;

@end

@implementation UMLoginViewController
- (IBAction)login:(id)sender {
    NSString *uname=_username.text;
    NSString *pwd=_password.text;
    NSString *string=[[[@"http://192.168.31.166:8080/vlogchinafreightsystem/accountAction!login.action?username=" stringByAppendingString:uname] stringByAppendingString:@"&password="] stringByAppendingString:pwd];
    NSURL *url=[NSURL URLWithString:string];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation=[[AFHTTPRequestOperation alloc]initWithRequest:request];
   // operation.responseSerializer=[AFJSONResponseSerializer serializer];
    operation.responseSerializer=[AFHTTPResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError *error;
        NSData *responseData=(NSData *)responseObject;
        NSDictionary *json=[NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
        NSString *message=(NSString *)[json objectForKey:@"message"];     //   NSString *message=[[NSString alloc]initWithData:[json objectForKey:@"message"] encoding:NSUTF8StringEncoding];
     //   NSNumber *branchcompanyid=(NSNumber *)[responseData objectForKey:@"branchcompanyid"];
        
        if ([message isEqualToString:@"登陆成功"])
        {
            [self performSegueWithIdentifier:@"login" sender:self];
        }
        else
        {
            UIAlertView *alertView2=[[UIAlertView alloc] initWithTitle: @"登陆失败" message:@"用户名或密码错误" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alertView2 show];
           
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle: @"网络不通" message:@"网络不通"delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alertView show];
           }];
    
    [operation start];
    
}

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


//#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
//}

@end
