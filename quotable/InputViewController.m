//
//  InputViewController.m
//  quotable
//
//  Created by Erika Johnson on 3/19/15.
//  Copyright (c) 2015 Erika Marie Johnson. All rights reserved.
//

#import "InputViewController.h"

@interface InputViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;
@property (weak, nonatomic) IBOutlet UITextField *quoteText;
@property (weak, nonatomic) IBOutlet UITextField *authorText;

@end

@implementation InputViewController

- (void)viewWillAppear:(BOOL) animated {
    [super viewWillAppear:animated];
    [self.quoteText becomeFirstResponder];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.saveButton.enabled = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL) textFieldShouldReturn: (UITextField *) textField {
    [textField resignFirstResponder];
    if (textField == self.quoteText) [self.authorText becomeFirstResponder];
    if (self.quoteText.hasText && self.authorText.hasText) {
        self.saveButton.enabled = YES;
    } else {
        self.saveButton.enabled = NO;
    }
    return YES;
}

- (IBAction) cancelButtonTapped: (id)sender {
    [self.view endEditing:YES];
    if (self.completionHandler) {
        self.completionHandler(nil, nil);
    }
}

- (IBAction) saveButtonTapped: (id)sender {
    [self.view endEditing:YES];
    if (self.completionHandler) {
        self.completionHandler(self.quoteText.text, self.authorText.text);
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
