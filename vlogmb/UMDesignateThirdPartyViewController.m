//
//  UMDesignateThirdPartyViewController.m
//  vlogmb
//
//  Created by 余少勇 on 14-9-19.
//  Copyright (c) 2014年 you-meng.com. All rights reserved.
//

#import "UMDesignateThirdPartyViewController.h"
#import "AFPickerView.h"

@interface UMDesignateThirdPartyViewController ()

@end

@implementation UMDesignateThirdPartyViewController

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
    pickerArray = [NSArray arrayWithObjects:@"动物",@"植物",@"石头",@"天空", nil];
    self.tfAircompany.inputView=self.pickView;
    self.tfAircompany.inputAccessoryView = self.doneToolbar;
    self.tfAircompany.delegate = self;
    
    self.tfPeercompany.inputView=self.pickView;
    //    self.tfAircompany.inputAccessoryView = doneToolbar;
    self.tfPeercompany.delegate = self;
    
    
    
    self.tfForeignagent.inputView=self.pickView;
    //    self.tfAircompany.inputAccessoryView = doneToolbar;
    self.tfForeignagent.delegate = self;
    
    
    
    self.tfWarehousecompany.inputView=self.pickView;
    //    self.tfAircompany.inputAccessoryView = doneToolbar;
    self.tfWarehousecompany.delegate = self;
    
    
    self.tfTruckcompany.inputView=self.pickView;
    //    self.tfAircompany.inputAccessoryView = doneToolbar;
    self.tfTruckcompany.delegate = self;
    
    
    self.tfPilecompany.inputView=self.pickView;
    //    self.tfAircompany.inputAccessoryView = doneToolbar;
    self.tfPilecompany.delegate = self;
    
    self.pickView.delegate = self;
    self.pickView.dataSource = self;
    self.pickView.frame = CGRectMake(0, 480, 320, 216);
}
-(void)viewDidAppear:(BOOL)animated
{
    //   [super viewDidAppear:<#animated#>];
    self.scrollView.contentSize=self.view.frame.size;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [pickerArray count];
}
-(NSString*) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [pickerArray objectAtIndex:row];
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    NSInteger row =[self.pickView selectedRowInComponent:0];
    
    switch (textField.tag) {
        case 1:
            self.tfAircompany.text = [pickerArray objectAtIndex:row];
            break;
        case 2:
            self.tfPeercompany.text = [pickerArray objectAtIndex:row];
            break;
        case 3:
            self.tfForeignagent.text = [pickerArray objectAtIndex:row];
            break;
        case 4:
            self.tfWarehousecompany.text = [pickerArray objectAtIndex:row];
            break;
        case 5:
            self.tfTruckcompany.text = [pickerArray objectAtIndex:row];
            break;
        case 6:
            self.tfPilecompany.text = [pickerArray objectAtIndex:row];
            break;
        default:
            break;
    }
    
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

- (IBAction)designate:(id)sender {
}

- (IBAction)select:(id)sender {
    
 //   [self.tfAircompany endEditing:true];
 //   [self.tfPeercompany endEditing:true];
 //   [self.tfWarehousecompany endEditing:true];
 //   [self.tfTruckcompany endEditing:true];
 //   [self.tfForeignagent endEditing:true];
 //   [self.tfPilecompany endEditing:true];
  //  [self resignFirstResponder];
}
-(BOOL)canBecomeFirstResponder
{
    return YES;
}
@end
