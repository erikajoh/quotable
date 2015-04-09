//
//  ViewController.m
//  quotable
//
//  Created by Erika Johnson on 2/25/15.
//  Copyright (c) 2015 Erika Marie Johnson. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>

#import "ViewController.h"

#define NSLog(FORMAT, ...) printf("%s\n", [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);

@interface ViewController ()
{
    AVAudioPlayer *_audioPlayer;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.quotes = [QuotesModel sharedModel];
    self.execBegin = false;
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapRecognized:)];
    singleTap.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:singleTap];
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGestureRecognized:)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeLeft];
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGestureRecognized:)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeRight];
    
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapRecognized:)];
    doubleTap.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:doubleTap];
    
    [singleTap requireGestureRecognizerToFail: doubleTap];
    
    NSString *path = [NSString stringWithFormat:@"%@/tone.mp3", [[NSBundle mainBundle] resourcePath]];
    NSURL *soundUrl = [NSURL fileURLWithPath:path];
    _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl error:nil];
    
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
    NSLog(@"\n--- END UNIT TEST ---\n\n");
    
    NSLog(@"Documents Directory: %@", [[[NSFileManager
                                         defaultManager] URLsForDirectory:NSDocumentDirectory
                                        inDomains:NSUserDomainMask] lastObject]);
    
}

-(void)viewDidAppear:(BOOL)animated {
    [self becomeFirstResponder];
    if (!self.execBegin) return;
    if ( ! [self.quotes isFavorite:self.quoteLabel.text author:self.authorLabel.text] )
        self.favoriteLabel.alpha = 0;
    if ( ! [self.quotes isQuote:self.quoteLabel.text author:self.authorLabel.text] ) {
        self.favoriteLabel.alpha = 0;
        NSDictionary *quote = [self.quotes nextQuote];
        if (!quote) {
            self.quoteLabel.text = @"No quotes to show";
            self.authorLabel.text = @":(";
        } else {
            self.quoteLabel.text = [quote valueForKey:@"quote"];
            self.authorLabel.text = [quote valueForKey:@"author"];
            if ( [self.quotes isFavorite:self.quoteLabel.text author:self.authorLabel.text] )
                self.favoriteLabel.alpha = 1;
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)singleTapRecognized: (UITapGestureRecognizer *) recognizer {
    self.execBegin = true;
    [_audioPlayer play];
    self.quoteLabel.alpha = 0;
    self.authorLabel.alpha = 0;
    self.favoriteLabel.alpha = 0;
    NSDictionary *quote = [self.quotes randomQuote];
    if (!quote) {
        self.quoteLabel.text = @"No quotes to show";
        self.authorLabel.text = @":(";
    } else {
        self.quoteLabel.text = [quote valueForKey:@"quote"];
        self.authorLabel.text = [quote valueForKey:@"author"];
        if ( [self.quotes isFavorite:self.quoteLabel.text author:self.authorLabel.text] )
            [UIView animateWithDuration:1.0 animations:^{ self.favoriteLabel.alpha = 1; }];
    }
    [UIView animateWithDuration:1.0 animations:^{
        self.quoteLabel.alpha = 1;
        self.authorLabel.alpha = 1;
    }];
}

- (void)doubleTapRecognized:(UITapGestureRecognizer *) recognizer {
    if (!self.execBegin) return;
    self.favoriteLabel.alpha = 0;
    [self.quotes addFavorite:self.quoteLabel.text author:self.authorLabel.text];
    [UIView animateWithDuration:1.0 animations:^{ self.favoriteLabel.alpha = 1; }];
}

- (void)swipeGestureRecognized: (UISwipeGestureRecognizer *) recognizer {
    self.execBegin = true;
    [_audioPlayer play];
    self.quoteLabel.alpha = 0;
    self.authorLabel.alpha = 0;
    self.favoriteLabel.alpha = 0;
    if (recognizer.direction == UISwipeGestureRecognizerDirectionLeft) {
        NSDictionary *quote = [self.quotes nextQuote];
        if (!quote) {
            self.quoteLabel.text = @"No quotes to show";
            self.authorLabel.text = @":(";
        } else {
            self.quoteLabel.text = [quote valueForKey:@"quote"];
            self.authorLabel.text = [quote valueForKey:@"author"];
            if ( [self.quotes isFavorite:self.quoteLabel.text author:self.authorLabel.text] )
                [UIView animateWithDuration:1.0 animations:^{ self.favoriteLabel.alpha = 1; }];
        }
    }
    if (recognizer.direction == UISwipeGestureRecognizerDirectionRight) {
        NSDictionary *quote = [self.quotes prevQuote];
        if (!quote) {
            self.quoteLabel.text = @"No quotes to show";
            self.authorLabel.text = @":(";
        } else {
            self.quoteLabel.text = [quote valueForKey:@"quote"];
            self.authorLabel.text = [quote valueForKey:@"author"];
            if ( [self.quotes isFavorite:self.quoteLabel.text author:self.authorLabel.text] )
                [UIView animateWithDuration:1.0 animations:^{ self.favoriteLabel.alpha = 1; }];
        }
    }
    [UIView animateWithDuration:1.0 animations:^{
        self.quoteLabel.alpha = 1;
        self.authorLabel.alpha = 1;
    }];
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (void)motionEnded: (UIEventSubtype) motion withEvent: (UIEvent*) event {
    self.execBegin = true;
    [_audioPlayer play];
    self.quoteLabel.alpha = 0;
    self.authorLabel.alpha = 0;
    self.favoriteLabel.alpha = 0;
    NSDictionary *quote = [self.quotes randomQuote];
    if (!quote) {
        self.quoteLabel.text = @"No quotes to show";
        self.authorLabel.text = @":(";
    } else {
        self.quoteLabel.text = [quote valueForKey:@"quote"];
        self.authorLabel.text = [quote valueForKey:@"author"];
        if ( [self.quotes isFavorite:self.quoteLabel.text author:self.authorLabel.text] )
            [UIView animateWithDuration:1.0 animations:^{ self.favoriteLabel.alpha = 1; }];
    }
    [UIView animateWithDuration:1.0 animations:^{
        self.quoteLabel.alpha = 1;
        self.authorLabel.alpha = 1;
    }];
}

- (IBAction)soundSwitchChanged:(id)sender {
    if([sender isOn]){
        _audioPlayer.volume = 1.0;
    } else{
        _audioPlayer.volume = 0.0;
    }
}

@end
