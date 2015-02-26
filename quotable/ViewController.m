//
//  ViewController.m
//  quotable
//
//  Created by Erika Johnson on 2/25/15.
//  Copyright (c) 2015 Erika Marie Johnson. All rights reserved.
//

#import "ViewController.h"

#define NSLog(FORMAT, ...) printf("%s\n", [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.quotes = [[QuotesModel alloc] init];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapRecognized:)];
    [self.view addGestureRecognizer:singleTap];
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGestureRecognized:)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeLeft];
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGestureRecognized:)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeRight];
    
    NSLog(@"--- BEGIN UNIT TEST ---\n");
    NSLog(@"INSERT QUOTE WITH AUTHOR AT INDEX 0");
    [self.quotes insertQuote:@"If music be the food of love, play on" author:@"Shakespeare" atIndex:0];
    NSLog(@"GET QUOTE AT INDEX 0: %@", [self.quotes quoteAtIndex:0]);
    NSLog(@"INSERT QUOTE WITHOUT AUTHOR AT INDEX 1");
    [self.quotes insertQuote:@"No one can make you feel inferior without your consent" atIndex:1];
    NSLog(@"GET QUOTE AT INDEX 1: %@", [self.quotes quoteAtIndex:1]);
    NSLog(@"REMOVE QUOTE AT INDEX 1");
    [self.quotes removeQuoteAtIndex:1];
    NSLog(@"GET QUOTE AT INDEX 0: %@", [self.quotes quoteAtIndex:0]);
    NSLog(@"GET QUOTE AT INDEX 1: %@", [self.quotes quoteAtIndex:1]);
    NSLog(@"REMOVE QUOTE AT INDEX 0");
    [self.quotes removeQuoteAtIndex:0];
    NSLog(@"GET QUOTE AT INDEX 0: %@", [self.quotes quoteAtIndex:0]);
    NSLog(@"GET QUOTE AT INDEX 1: %@", [self.quotes quoteAtIndex:1]);
    NSLog(@"SUCCESSFULLY INSERTED QUOTE WITH AUTHOR, QUOTE WITHOUT AUTHOR, GOT AND REMOVED BOTH QUOTES");
    NSLog(@"\n--- END UNIT TEST ---");
    
    [self.quotes insertQuote:@"If music be the food of love, play on" author:@"William Shakespeare" atIndex:0];
    [self.quotes insertQuote:@"No one can make you feel inferior without your consent" author:@"Eleanor Roosevelt" atIndex:1];
    [self.quotes insertQuote:@"You are the music while the music lasts" author:@"T.S. Eliot" atIndex:2];
    [self.quotes insertQuote:@"Be the change you want to see in the world" author:@"Mahatma Gandhi" atIndex:3];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)singleTapRecognized: (UITapGestureRecognizer *) recognizer {
    self.quoteLabel.alpha = 0;
    self.authorLabel.alpha = 0;
    NSDictionary *quote = [self.quotes randomQuote];
    self.quoteLabel.text = [quote valueForKey:@"quote"];
    self.authorLabel.text = [quote valueForKey:@"author"];
    [UIView animateWithDuration:1.0 animations:^{
        self.quoteLabel.alpha = 1;
        self.authorLabel.alpha = 1;
    }];
}

- (void)swipeGestureRecognized: (UISwipeGestureRecognizer *) recognizer {
    self.quoteLabel.alpha = 0;
    self.authorLabel.alpha = 0;
    if (recognizer.direction == UISwipeGestureRecognizerDirectionLeft) {
        NSDictionary *quote = [self.quotes nextQuote];
        self.quoteLabel.text = [quote valueForKey:@"quote"];
        self.authorLabel.text = [quote valueForKey:@"author"];
    }
    if (recognizer.direction == UISwipeGestureRecognizerDirectionRight) {
        NSDictionary *quote = [self.quotes prevQuote];
        self.quoteLabel.text = [quote valueForKey:@"quote"];
        self.authorLabel.text = [quote valueForKey:@"author"];
    }
    [UIView animateWithDuration:1.0 animations:^{
        self.quoteLabel.alpha = 1;
        self.authorLabel.alpha = 1;
    }];
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (void)viewDidAppear: (BOOL)animated {
    [self becomeFirstResponder];
}

- (void)motionEnded: (UIEventSubtype) motion withEvent: (UIEvent*) event {
    self.quoteLabel.alpha = 0;
    self.authorLabel.alpha = 0;
    NSDictionary *quote = [self.quotes randomQuote];
    self.quoteLabel.text = [quote valueForKey:@"quote"];
    self.authorLabel.text = [quote valueForKey:@"author"];
    [UIView animateWithDuration:1.0 animations:^{
        self.quoteLabel.alpha = 1;
        self.authorLabel.alpha = 1;
    }];
}

@end
