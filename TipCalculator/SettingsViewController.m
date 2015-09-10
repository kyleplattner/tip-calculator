//
//  SettingsViewController.m
//  TipCalculator
//
//  Created by Kyle Plattner on 9/9/15.
//  Copyright (c) 2014 Kyle Plattner. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()
- (IBAction)onTap:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *midpointTextField;
@property (weak, nonatomic) IBOutlet UITextField *offsetTextField;

@end

@implementation SettingsViewController

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
    // Do any additional setup after loading the view from its nib.
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.midpointTextField.text = [defaults stringForKey:@"midpoint"];
    self.offsetTextField.text = [defaults stringForKey:@"offset"];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onTap:(id)sender {
    [self.view endEditing:YES];
    
    int midpoint = [self.midpointTextField.text intValue];
    int offset = [self.offsetTextField.text intValue];
    
    if (midpoint > 100){
        //warn user
    } else if (offset > midpoint){
        //offset cannot be larger than the midpoint
    } else if (midpoint - offset < 0){
        //offset from midpoint cannot go below 0
    } else {
    
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setInteger:midpoint forKey:@"midpoint"];
        [defaults setInteger:offset forKey:@"offset"];
        [defaults synchronize];
    }
}
@end
