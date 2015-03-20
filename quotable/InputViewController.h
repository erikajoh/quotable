//
//  InputViewController.h
//  quotable
//
//  Created by Erika Johnson on 3/19/15.
//  Copyright (c) 2015 Erika Marie Johnson. All rights reserved.
//

#import "ViewController.h"

typedef void(^InputCompletionHandler)(NSString *quote, NSString *author);

@interface InputViewController : UIViewController
@property (copy, nonatomic) InputCompletionHandler completionHandler;
- (IBAction)saveButtonTapped:(id)sender;
- (IBAction)cancelButtonTapped:(id)sender;

@end
