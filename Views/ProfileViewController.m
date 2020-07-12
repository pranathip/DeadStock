//
//  ProfileViewController.m
//  DeadStock
//
//  Created by Pranathi Peri on 7/9/20.
//  Copyright © 2020 Pranathi Peri. All rights reserved.
//

#import "ProfileViewController.h"
#import "ImageHelper.h"

@interface ProfileViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    PFUser *currentUser = [PFUser currentUser];
    // Configure profile picture to show current user data
    self.profilePictureView.layer.cornerRadius = 45;
    [self.profilePictureView.layer setBorderColor: [[UIColor lightGrayColor] CGColor]];
    [self.profilePictureView.layer setBorderWidth: 1.5];
    self.profilePictureView.file = currentUser[@"profilePicture"];
    [self.profilePictureView loadInBackground];
    
    // Configure text fields to show current user data
    self.emailTextField.text = currentUser.email;
    self.firstNameTextField.text = currentUser[@"firstName"];
    self.lastNameTextField.text = currentUser[@"lastName"];
    self.usernameTextField.text = currentUser.username;
    self.nameHeaderLabel.text = [NSString stringWithFormat:@"%@ %@", currentUser[@"firstName"], currentUser[@"lastName"]];
    
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
    
    PFUser *currentUser = [PFUser currentUser];
    currentUser[@"profilePicture"] = [ImageHelper getPFFileFromImage:[ImageHelper resizeImage:self.profilePictureView.image withSize:CGSizeMake(100, 100)]];
    
    [currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"Profile picture updated");
        } else {
            NSLog(@"Error updating profile picture: %@", error.localizedDescription);
        }
    }];
    
    // Dismiss UIImagePickerController to go back to your original view controller
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)logOutButtonTapped:(id)sender {
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        // PFUser.current() will now be nil
        [self performSegueWithIdentifier:@"logOutSegue" sender:nil];
    }];
}

- (IBAction)firstNameEditingEnd:(id)sender {
    [self refreshView];
}

- (IBAction)lastNameEditingEnd:(id)sender {
    [self refreshView];
}

- (void)refreshView {
    PFUser *currentUser = [PFUser currentUser];
    self.nameHeaderLabel.text = [NSString stringWithFormat:@"%@ %@", currentUser[@"firstName"], currentUser[@"lastName"]];
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
