//
//  UMDesignateThirdPartyViewController.h
//  vlogmb
//
//  Created by 余少勇 on 14-9-19.
//  Copyright (c) 2014年 you-meng.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UMDesignateThirdPartyViewController : UIViewController<UIPickerViewDelegate, UITextFieldDelegate,UIPickerViewDataSource>
{
    NSArray *pickerArray;
}
@property (weak, nonatomic) IBOutlet UIPickerView *pickView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UITextField *tfAircompany;
@property (weak, nonatomic) IBOutlet UITextField *tfPeercompany;
@property (weak, nonatomic) IBOutlet UITextField *tfForeignagent;
@property (weak, nonatomic) IBOutlet UITextField *tfWarehousecompany;
@property (weak, nonatomic) IBOutlet UITextField *tfTruckcompany;
@property (weak, nonatomic) IBOutlet UITextField *tfPilecompany;
@property (weak, nonatomic) IBOutlet UIToolbar *doneToolbar;


- (IBAction)designate:(id)sender;
- (IBAction)select:(id)sender;

@end
