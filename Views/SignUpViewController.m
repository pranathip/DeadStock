//
//  SignUpViewController.m
//  DeadStock
//
//  Created by Pranathi Peri on 7/9/20.
//  Copyright © 2020 Pranathi Peri. All rights reserved.
//

#import "SignUpViewController.h"
#import "ImageHelper.h"

@interface SignUpViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Profile picture styling
    self.profilePictureView.layer.cornerRadius = 32;
    self.smallWhiteView.layer.cornerRadius = 10;
    
    // Set up animation labels
    self.animatedEmailLabel.alpha = 0;
    self.animatedFirstNameLabel.alpha = 0;
    self.animatedLastNameLabel.alpha = 0;
    self.animatedUsernameLabel.alpha = 0;
    self.animatedPasswordLabel.alpha = 0;
    
    
}
- (IBAction)didTapSignUpButton:(id)sender {
    //  If the username or password fields are left blank, throw an alert controller
    NSLog(@"tapped");
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    if ([self.firstNameTextField.text isEqualToString:@""] ||[self.usernameTextField.text isEqualToString:@""] || [self.passwordTextField.text isEqualToString:@""] || [self.emailTextField.text isEqualToString:@""]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error Signing Up"
               message:@"The required fields must not be left blank."
        preferredStyle:(UIAlertControllerStyleAlert)];
        // create a cancel action
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Try Again" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            // handle cancel response here. Doing nothing will dismiss the view.
        }];
        // add the cancel action to the alertController
        [alert addAction:cancelAction];
        
        [self presentViewController:alert animated:YES completion:^{
            // optional code for what happens after the alert controller has finished presenting
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }];
    }
    
    // Initialize a new user
    PFUser *newUser = [PFUser user];
    
    // set user properties
    newUser.email = self.emailTextField.text;
    newUser[@"firstName"] = self.firstNameTextField.text;
    newUser[@"lastName"] = self.lastNameTextField.text;
    newUser.username = self.usernameTextField.text;
    newUser.password = self.passwordTextField.text;
    newUser[@"profilePicture"] = [ImageHelper getPFFileFromImage:[ImageHelper resizeImage:self.profilePictureView.image withSize:CGSizeMake(100, 100)]];
    
    // call sign up function on the object
    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
        if (error != nil) {
            NSLog(@"Error: %@", error.localizedDescription);
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error Signing Up" message:error.localizedDescription
            preferredStyle:(UIAlertControllerStyleAlert)];
            // create a cancel action
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Try Again" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                // handle cancel response here. Doing nothing will dismiss the view.
            }];
            // add the cancel action to the alertController
            [alert addAction:cancelAction];
            
            [self presentViewController:alert animated:YES completion:^{
                // optional code for what happens after the alert controller has finished presenting
                [MBProgressHUD hideHUDForView:self.view animated:YES];
            }];
        } else {
            NSLog(@"User registered successfully");
            // manually segue to logged in view
            [self performSegueWithIdentifier:@"signupSegue" sender:nil];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }
    }];
}

- (IBAction)didTapProfilePicture:(id)sender {
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:imagePickerVC animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    // Get the image captured by the UIImagePickerController
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    
    //UIImage *editedImage = info[UIImagePickerControllerEditedImage];

    // Do something with the images (based on your use case)
    self.profilePictureView.image = originalImage;
    
    // Dismiss UIImagePickerController to go back to your original view controller
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)didTapCloseButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

// TEXT FIELD ANIMATIONS
- (IBAction)emailEditingBegin:(id)sender {
    [self editingBeganOnField:self.emailTextField withAnimationLabel:self.animatedEmailLabel];
}
- (IBAction)emailEditingEnd:(id)sender {
    [self editingEndedOnField:self.emailTextField withAnimationLabel:self.animatedEmailLabel withPlaceholder:@"EMAIL"];
}
- (IBAction)firstNameEditingBegin:(id)sender {
    [self editingBeganOnField:self.firstNameTextField withAnimationLabel:self.animatedFirstNameLabel];
}
- (IBAction)firstNameEditingEnd:(id)sender {
    [self editingEndedOnField:self.firstNameTextField withAnimationLabel:self.animatedFirstNameLabel withPlaceholder:@"FIRST NAME"];
}
- (IBAction)lastNameEditingBegin:(id)sender {
    [self editingBeganOnField:self.lastNameTextField withAnimationLabel:self.animatedLastNameLabel];
}
- (IBAction)lastNameEditingEnd:(id)sender {
    [self editingEndedOnField:self.lastNameTextField withAnimationLabel:self.animatedLastNameLabel withPlaceholder:@"LAST NAME"];
}
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
        [UIView animateWithDuration:0.4 animations:^{
            label.frame = newFrame;
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
