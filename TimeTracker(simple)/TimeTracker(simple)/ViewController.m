//
//  ViewController.m
//  TimeTracker(simple)
//
//  Created by Ethan Hess on 5/15/15.
//  Copyright (c) 2015 Ethan Hess. All rights reserved.
//

#import "ViewController.h"
#import "EntryController.h" 

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIDatePicker *startTimePicker;
@property (weak, nonatomic) IBOutlet UIDatePicker *endTimePicker;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.navigationController.navigationBarHidden = NO; 
}


- (IBAction)save:(id)sender {
    
    [self alertView];
    
}

- (void)alertView {
    
    NSDate *startTime = self.startTimePicker.date;
    NSDate *endTime = self.endTimePicker.date;
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Enter Title" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        
        textField.placeholder = @"Add title";
    }];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Save" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        [[EntryController sharedInstance]addEntryWithTitle:((UITextField *)alertController.textFields[0]).text startTime:startTime endTime:endTime];
        
        }]];
     
    
    [self presentViewController:alertController animated:YES completion:nil];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
