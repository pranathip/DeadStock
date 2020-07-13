//
//  LogInViewController.m
//  DeadStock
//
//  Created by Pranathi Peri on 7/9/20.
//  Copyright © 2020 Pranathi Peri. All rights reserved.
//

#import "LogInViewController.h"
@import Parse;
@import MBProgressHUD;

@interface LogInViewController ()

@end

@implementation LogInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Set up animation labels
    self.animatedUsernameLabel.alpha = 0;
    self.animatedPasswordLabel.alpha = 0;
}
- (IBAction)signUpButtonTapped:(id)sender {
    [self dismissViewControllerAnimated:TRUE completion:nil];
}
- (IBAction)didTapLoginButton:(id)sender {
    NSString *username = self.usernameTextField.text;
    NSString *password = self.passwordTextField.text;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
        if (error != nil) {
            NSLog(@"User log in failed: %@", error.localizedDescription);
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error Logging In" message:error.localizedDescription
            preferredStyle:(UIAlertControllerStyleAlert)];
            // create a cancel action
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Try Again" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                // handle cancel response here. Doing nothing will dismiss the view.
            }];
            // add the cancel action to the alertController
            [alert addAction:cancelAction];
            
            [self presentViewController:alert animated:YES completion:^{
                // optional code for what happens after the alert controller has finished presenting
            }];
        } else {
            NSLog(@"User logged in successfully");
            
            // display view controller that needs to shown after successful login
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self performSegueWithIdentifier:@"loginSegue" sender:nil];
        }
    }];
}
- (IBAction)didTapCloseButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


// TEXT FIELD ANIMATIONS
- (IBAction)usernameEditingBegin:(id)sender {
    [self editingBeganOnField:self.usernameTextField withAnimationLabel:self.animatedUsernameLabel];
}
- (IBAction)usernameEditingEnd:(id)sender {
    [self editingEndedOnField:self.usernameTextField withAnimationLabel:self.animatedUsernameLabel withPlaceholder:@"USERNAME"];
}
- (IBAction)passwordEditingBegin:(id)sender {
    [self editingBeganOnField:self.passwordTextField withAnimationLabel:self.animatedPasswordLabel];
}
- (IBAction)passwordEditingEnd:(id)sender {
    [self editingEndedOnField:self.passwordTextField withAnimationLabel:self.animatedPasswordLabel withPlaceholder:@"PASSWORD"];
}

// TEXT FIELD ANIMATION HELPER METHODS
- (void)editingBeganOnField:(UITextField *)textField withAnimationLabel:(UILabel *)label{
    if (label.alpha != 1) {
        NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:textField attribute:NSLayoutAttributeTop multiplier:1 constant:-35];
        [self.view addConstraint:top];
        //[label.bottomAnchor constraintEqualToAnchor:textField.bottomAnchor].active = NO;
        CGRect newFrame = label.frame;
        newFrame.origin.y -=35;
        [UIView animateWithDuration:0.4 animations:^{
            label.frame = newFrame;
            label.alpha = 1;
            textField.placeholder = @"";
        }];
    }
}

- (void)editingEndedOnField:(UITextField *)textField withAnimationLabel:(UILabel *)label withPlaceholder:(NSString *)placeholder {
    if ([textField.text isEqual:@""]) {
        CGRect newFrame = label.frame;
        newFrame.origin.y +=15;
        
        [UIView animateWithDuration:0.1 animations:^{
            //label.frame = newFrame;
            label.alpha = 0;
            textField.placeholder = placeholder;
        }];
        
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
