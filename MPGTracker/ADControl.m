//
//  ADControl.m
//  MPGTracker
//
//  Created by Alex Dong on 1/31/13.
//  Copyright (c) 2013 Alex Dong. All rights reserved.
//

#import "ADControl.h"
#import "ADMainScreen.h"
#import "ADMainScreenTabViewController.h"

@interface ADControl()

@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UILabel *display;

@end

@implementation ADControl


- (IBAction)submit {
    self.display.text = [NSString  stringWithFormat: @"%@%@%@", self.username.text, @",", self.password.text];
    if(true || ([self.username.text isEqualToString:@"test"] && [self.password.text isEqualToString:@"test"])){
        ADMainScreenTabViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"mainscreentab"];
        [self.navigationController pushViewController:controller animated:YES];
        UIBarButtonItem *logOut = [[UIBarButtonItem alloc] initWithTitle:@"Log Out" style:UIBarButtonItemStyleBordered target:nil action:nil];
        [[self navigationItem] setBackBarButtonItem:logOut];
        [[self navigationController] setNavigationBarHidden:YES];
    }
}

- (IBAction)backgroundTouched:(id)sender {
    [self.view endEditing:YES];
}
- (IBAction) doneEditing: (id) sender {
    [sender resignFirstResponder];
}






@end	
