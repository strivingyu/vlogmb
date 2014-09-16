//
//  UMModifyPasswordViewController.h
//  vlogmb
//
//  Created by 余少勇 on 14-9-16.
//  Copyright (c) 2014年 you-meng.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UMModifyPasswordViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *newerPassword;
@property (weak, nonatomic) IBOutlet UITextField *confirmPassword;
- (IBAction)modify:(id)sender;

@end
