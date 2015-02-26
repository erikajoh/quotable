//
//  QuotesModel.m
//  quotable
//
//  Created by Erika Johnson on 2/25/15.
//  Copyright (c) 2015 Erika Marie Johnson. All rights reserved.
//

#import "QuotesModel.h"

@implementation QuotesModel

- (id)init {
    self = [super init];
    if (self) {
        self.currentIndex = 0;
        self.quotes = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSDictionary*)randomQuote {
    NSUInteger temp = _currentIndex;
    while (_currentIndex == temp) _currentIndex = arc4random() % [self numberOfQuotes];
    return [self.quotes objectAtIndex:self.currentIndex];
}

- (NSUInteger)numberOfQuotes {
    return [self.quotes count];
}

- (NSDictionary*)quoteAtIndex: (NSUInteger)index {
    if (index >= [self numberOfQuotes]) return nil;
    return [self.quotes objectAtIndex:index];
}

- (void)removeQuoteAtIndex: (NSUInteger)index {
    if (index >= [self numberOfQuotes]) return;
    [self.quotes removeObjectAtIndex:index];
}

- (void)insertQuote: (NSString*)quote author: (NSString*)author atIndex: (NSUInteger)index {
    if (index > [self numberOfQuotes]) return;
    NSDictionary* newQuote = @{@"quote":quote, @"author":author};
    [self.quotes insertObject:newQuote atIndex:index];
}

- (void)insertQuote: (NSString*)quote atIndex: (NSUInteger)index {
    if (index > [self numberOfQuotes]) return;
    NSDictionary* newQuote = @{@"quote":quote, @"author":@""};
    [self.quotes insertObject:newQuote atIndex:index];
}

- (NSDictionary*)nextQuote {
    if (self.currentIndex == [self numberOfQuotes] - 1) self.currentIndex = 0;
    else self.currentIndex++;
    return [self.quotes objectAtIndex:self.currentIndex];
}

- (NSDictionary*)prevQuote {
    if (self.currentIndex == 0) self.currentIndex = [self numberOfQuotes] - 1;
    else self.currentIndex--;
    return [self.quotes objectAtIndex:self.currentIndex];
}

@end
