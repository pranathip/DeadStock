//
//  SignUpViewController.h
//  DeadStock
//
//  Created by Pranathi Peri on 7/9/20.
//  Copyright © 2020 Pranathi Peri. All rights reserved.
//

#import <UIKit/UIKit.h>
@import Parse;

NS_ASSUME_NONNULL_BEGIN

@interface SignUpViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet PFImageView *profilePictureView;
@property (weak, nonatomic) IBOutlet UILabel *animatedEmailLabel;
@property (weak, nonatomic) IBOutlet UILabel *animatedFirstNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *animatedLastNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *animatedUsernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *animatedPasswordLabel;
@property (weak, nonatomic) IBOutlet UIView *smallWhiteView;
@end

NS_ASSUME_NONNULL_END
