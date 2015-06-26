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

- (IBAction)submitButtonTapped:(id)sender;

@end

@implementation FISViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
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
    NSLog(@"%@", textField.text);
    if ([self isValidName:textField.text]) {
        NSLog(@"it's a valid name!");
        self.lastName.enabled = YES;
        [self.lastName becomeFirstResponder];
    }
    
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

- (BOOL)isValidName:(NSString*)stringToTest
{
    NSScanner *scanner = [NSScanner scannerWithString:stringToTest];
    NSCharacterSet *digits = [NSCharacterSet decimalDigitCharacterSet];
    BOOL containsDigits = [scanner scanUpToCharactersFromSet:digits intoString:NULL];
    
    
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
