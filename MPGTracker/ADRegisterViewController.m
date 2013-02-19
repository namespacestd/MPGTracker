//
//  ADRegisterViewController.m
//  MPGTracker
//
//  Created by Alex Dong on 2/1/13.
//  Copyright (c) 2013 Alex Dong. All rights reserved.
//

#import "ADRegisterViewController.h"

@interface ADRegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *firstName;
@property (weak, nonatomic) IBOutlet UITextField *lastName;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *company;
@property (weak, nonatomic) IBOutlet UITextField *userName;	
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *passwordConfirm;
@property (weak, nonatomic) IBOutlet UILabel *errorMessage;

@end

@implementation ADRegisterViewController

- (IBAction)backgroundTouched:(id)sender {
    [self.view endEditing:YES];
}
- (IBAction)doneEditing:(UITextField *)sender {
    if ([sender.text isEqual:@""])
        sender.backgroundColor = [UIColor redColor];
    else
        sender.backgroundColor = [UIColor clearColor];
    
    [sender resignFirstResponder];
}	
- (IBAction)makeAccount:(id)sender{
    bool hasInvalid = NO;
    if ([self.firstName.text isEqual:@""]){
        self.firstName.backgroundColor = [UIColor redColor];
        hasInvalid = YES;
    }
    else
        self.firstName.backgroundColor = [UIColor clearColor];
    if ([self.lastName.text isEqual:@""]){
        self.lastName.backgroundColor = [UIColor redColor];
        hasInvalid = YES;
    }
    else
        self.lastName.backgroundColor = [UIColor clearColor];
    if ([self.email.text isEqual:@""]){
        self.email.backgroundColor = [UIColor redColor];
        hasInvalid = YES;
    }
    else
        self.email.backgroundColor = [UIColor clearColor];
    if ([self.company.text isEqual:@""]){
        self.company.backgroundColor = [UIColor redColor];
        hasInvalid = YES;
    }
    else
        self.company.backgroundColor = [UIColor clearColor];
    if ([self.userName.text isEqual:@""]){
        self.userName.backgroundColor = [UIColor redColor];
        hasInvalid = YES;
    }
    else
        self.userName.backgroundColor = [UIColor clearColor];
    if ([self.password.text isEqual:@""]){
        self.password.backgroundColor = [UIColor redColor];
        hasInvalid = YES;
    }
    else
        self.password.backgroundColor = [UIColor clearColor];
    if (![self.passwordConfirm.text isEqual:self.password.text]){
        self.passwordConfirm.backgroundColor = [UIColor redColor];
        hasInvalid = YES;
    }
    else
        self.passwordConfirm.backgroundColor = [UIColor clearColor];
    
    if (hasInvalid)
        self.errorMessage.hidden = NO;
    else
        [self.navigationController popViewControllerAnimated:YES];
    
}

@end
