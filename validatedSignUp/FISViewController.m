//
//  FISViewController.m
//  validatedSignUp
//
//  Created by Joe Burgess on 7/2/14.
//  Copyright (c) 2014 Joe Burgess. All rights reserved.
//
/**
 pod 'NSString+email' (caveat: uses an overly strict regex)
 
 In real life, follow this advice:
http://davidcel.is/posts/stop-validating-email-addresses-with-regex/
 */

#import "FISViewController.h"
#import <NSString+Email.h>

@interface FISViewController ()
@property (strong, nonatomic) IBOutlet UITextField *firstName;
@property (strong, nonatomic) IBOutlet UITextField *lastName;
@property (strong, nonatomic) IBOutlet UITextField *email;
@property (strong, nonatomic) IBOutlet UITextField *userName;
@property (strong, nonatomic) IBOutlet UITextField *password;
@property (strong, nonatomic) IBOutlet UIButton *submitButton;

@property (nonatomic, strong) NSDictionary *alertMessageMenu;

- (IBAction)submitButtonTapped:(id)sender;

@end

@implementation FISViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    _alertMessageMenu = @{@"forInvalidName"     : @"You entered an invalid name. Names cannot be empty, and cannot include digits.",
                          @"forInvalidEmail"    : @"You entered an invalid e-mail address. E-mail addresses must be of the form \"foo@example.com\".",
                          @"forInvalidPassword" : @"You entered an invalid password. Passwords must be at least 7 characters long, and easy to guess, like, say, your birthday. Because nobody will ever guess that."};
    [self setDelegatesAndTags];
    
    [self.firstName becomeFirstResponder];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSMutableString *alertMessage = [[NSMutableString alloc] init];
    
    NSLog(@"%@", textField.text);
    if (self.firstName == textField && [self isValidName:textField.text]) {
        self.lastName.enabled = YES;
        [self.lastName becomeFirstResponder];
   
    } else if (self.lastName == textField && [self isValidName:textField.text]) {
        self.email.enabled = YES;
        [self.email becomeFirstResponder];
    
    } else if (self.email == textField && [textField.text isEmail]) {
        self.userName.enabled = YES;
        [self.userName becomeFirstResponder];
    
    } else if (self.userName == textField && [self isValidName:textField.text]){
        self.password.enabled = YES;
        [self.password becomeFirstResponder];

    } else if (self.password == textField && [self isValidPassword:textField.text]) {
        return YES;
    }
    
    
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Invalid Input" message:[alertMessage copy] preferredStyle:UIAlertControllerStyleAlert];
    
    
    
    return YES;
    //(isValid)? Move to next responder : UIAlert and try again;
}


- (IBAction)submitButtonTapped:(id)sender
{
    
}

#pragma mark - Delegate Methods

-(void)setDelegatesAndTags
{
    self.firstName.delegate = self;
    self.lastName.delegate = self;
    self.email.delegate = self;
    self.userName.delegate = self;
    self.password.delegate = self;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return textField == _firstName || [textField isFirstResponder];
}



#pragma mark - Helper Methods

-(BOOL)isValidInput:(UITextField*)userInput
{
    if (userInput == self.firstName || userInput == self.lastName || userInput == self.userName) {
        return [self isValidName:userInput.text];
    } else if (userInput == self.email) {
        return [self.email.text isEmail]; ///Cocoapod NSString extension, using regex check (so it's not perfect)
    } else if (userInput == self.password) {
        return [self isValidPassword:userInput.text];
    } else {
        return NO;
    }
}

- (BOOL)isValidName:(NSString*)stringToTest
{
    NSCharacterSet *digits = [NSCharacterSet decimalDigitCharacterSet];    
    BOOL hasNoDigits = [stringToTest rangeOfCharacterFromSet:digits].location == NSNotFound;
    BOOL containsDigits = !hasNoDigits;
    
    
    if (stringToTest.length == 0 || containsDigits) {
        return NO;
    }
    return YES;
}

-(BOOL)isValidPassword:(NSString*)passwordToTest
{
    return (passwordToTest.length > 6);
}



@end
