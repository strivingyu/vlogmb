//
//  UMLoginViewController.m
//  vlogmb
//
//  Created by 余少勇 on 14-9-10.
//  Copyright (c) 2014年 you-meng.com. All rights reserved.
//

#import "UMLoginViewController.h"
#import "UMAppDelegate.h"
#import "AFNetworking.h"

@interface UMLoginViewController ()



@end

@implementation UMLoginViewController
- (IBAction)login:(id)sender {
    NSString *uname=_username.text;
    NSString *pwd=_password.text;
    NSString *string=[[[[[UMAppDelegate basePath] stringByAppendingString:@"accountAction!login.action?username="] stringByAppendingString:uname] stringByAppendingString:@"&password="] stringByAppendingString:pwd];
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
            //在全局变量中保存用户所在分公司id
            NSNumber *branchcompanyid=(NSNumber *)[json objectForKey:@"branchcompanyid"];
            NSNumber *accountid=(NSNumber *)[json objectForKey:@"accountid"];
            UMAppDelegate *app=(UMAppDelegate *)[UIApplication sharedApplication].delegate;
            app.branchcompanyid=branchcompanyid;
            app.username=uname;
            app.accountid=accountid;
            //如果选择了记住密码，则把用户名和密码保存着文件中
            if ([self.remember isOn]) {
                //NSMutableArray *array=[[NSMutableArray alloc] init];
               /// [array addObject:uname];
               /// [array addObject:pwd];
              ///  [array writeToFile:[self dataFilePath] atomically:YES];
                NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
                [userDefaults setObject:uname forKey:@"username"];
                [userDefaults setObject:pwd forKey:@"password"];
                [userDefaults synchronize];
            }
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

-(NSString *)dataFilePath
{
    //常量NSDocumentDirectory表示我们正在查找Documents目录，NSUserDomainMask表示把搜索范围定在应用程序沙盒中
    //YES表示希望该函数能查看用户主目录
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask,YES);
    NSString *documentDirectory=[paths objectAtIndex:0];
    return [documentDirectory stringByAppendingPathComponent:@"appdata.txt"];
}




- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //检查数据文件是否存在，不存在则不加载
   // NSString *filePath=[self dataFilePath];
   // if([[NSFileManager defaultManager] fileExistsAtPath:filePath])
   // {
       // NSArray *array=[[NSArray alloc] initWithContentsOfFile:filePath];
       // self.username.text=[array objectAtIndex:0];
       // self.password.text=[array objectAtIndex:1];
         NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
         self.username.text=[userDefaults stringForKey:@"username"];
         self.password.text=[userDefaults stringForKey:@"password"];
  //  }
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
