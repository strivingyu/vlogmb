//
//  UMLoginViewController.h
//  vlogmb
//
//  Created by 余少勇 on 14-9-10.
//  Copyright (c) 2014年 you-meng.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UMLoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UISwitch *remember;
-(NSString *)dataFilePath;

@end
