//
//  QuotesModel.h
//  quotable
//
//  Created by Erika Johnson on 2/25/15.
//  Copyright (c) 2015 Erika Marie Johnson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QuotesModel : NSObject

@property (strong, nonatomic) NSMutableArray *quotes;
@property (nonatomic) NSUInteger currentIndex;

+ (instancetype) sharedModel;

- (NSDictionary*)randomQuote;
- (NSUInteger)numberOfQuotes;
- (NSDictionary*)quoteAtIndex: (NSUInteger)index;
- (void)removeQuoteAtIndex: (NSUInteger)index;
- (void)insertQuote: (NSString*)quote author: (NSString*)author atIndex: (NSUInteger)index;
- (void)insertQuote: (NSString*)quote atIndex: (NSUInteger)index;
- (NSDictionary*)nextQuote;
- (NSDictionary*)prevQuote;

@end
