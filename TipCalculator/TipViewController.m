//
//  TipViewController.m
//  TipCalculator
//
//  Created by Kyle Plattner on 9/9/15.
//  Copyright (c) 2014 Kyle Plattner. All rights reserved.
//

#import "TipViewController.h"
#import "SettingsViewController.h"

@interface TipViewController ()
@property (weak, nonatomic) IBOutlet UITextField *billTextField;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipControl;
@property int midpoint;
@property int offset;
@property NSArray *tipValues;

- (IBAction)onTap:(id)sender;
- (void)updateValues;
- (void)updateLabels;
- (void)onSettingsButton;

@end

@implementation TipViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Tip Calculator";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(onSettingsButton)];
    
    [self updateLabels];
    // Do any additional setup after loading the view from its nib.
    [self updateValues];
}

- (void)viewDidAppear:(BOOL)animated {
    [self updateLabels];
    [self updateValues];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onTap:(id)sender {
    [self.view endEditing:YES];
    [self updateValues];
}

- (void)updateLabels {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.midpoint = [defaults integerForKey:@"midpoint"];
    self.offset = [defaults integerForKey:@"offset"];
    
    if (self.midpoint < 1){
        self.midpoint = 15;
    }
    if (self.offset < 1){
        self.offset = 5;
    }
    
    [self.tipControl setTitle:[NSString stringWithFormat:@"%d%%", self.midpoint-self.offset] forSegmentAtIndex:0 ];
    [self.tipControl setTitle:[NSString stringWithFormat:@"%d%%", self.midpoint] forSegmentAtIndex:1 ];
    [self.tipControl setTitle:[NSString stringWithFormat:@"%d%%", self.midpoint+self.offset] forSegmentAtIndex:2 ];
    
    self.tipValues = @[@((float)(self.midpoint-self.offset)/100), @((float)self.midpoint/100), @((float)(self.midpoint+self.offset)/100) ];
    

}

- (void)updateValues {
    
    float billAmount = [self.billTextField.text floatValue];
    
    
    float tipAmount = billAmount * [self.tipValues[self.tipControl.selectedSegmentIndex] floatValue];
    
    float totalAmount = tipAmount + billAmount;
    self.tipLabel.text = [NSString stringWithFormat:@"$%0.2f", tipAmount];
    self.totalLabel.text = [NSString stringWithFormat:@"$%0.2f", totalAmount];
}

- (void)onSettingsButton {
    [self.navigationController pushViewController:[[SettingsViewController alloc] init] animated:YES];
}
@end
