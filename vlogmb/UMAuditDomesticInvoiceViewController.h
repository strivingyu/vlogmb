//
//  UMAuditDomesticInvoiceViewController.h
//  vlogmb
//
//  Created by 余少勇 on 14-9-18.
//  Copyright (c) 2014年 you-meng.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UMAuditDomesticInvoiceViewController : UIViewController
@property (strong, nonatomic) NSString *workno;
@property (strong, nonatomic) NSNumber *denominated;
@property (strong, nonatomic) NSString *memo;
@property (strong, nonatomic) NSString *serialno;
@property (weak, nonatomic) IBOutlet UITextField *tfWorkno;
@property (weak, nonatomic) IBOutlet UITextField *tfTitle;
@property (weak, nonatomic) IBOutlet UITextView *tvDetail;
@property (weak, nonatomic) IBOutlet UITextView *tvOthers;
- (IBAction)pass:(id)sender;
- (IBAction)refuse:(id)sender;
@end
