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
@property (strong, nonatomic) NSMutableArray *favorites;
@property (nonatomic) NSUInteger currentIndex;
@property (strong, nonatomic) NSString *quotesPath;
@property (strong, nonatomic) NSString *favoritesPath;

+ (instancetype) sharedModel;

- (NSDictionary*)randomQuote;
- (NSUInteger)numberOfQuotes;
- (NSDictionary*)quoteAtIndex: (NSUInteger)index;
- (void)removeQuoteAtIndex: (NSUInteger)index;
- (void)insertQuote: (NSString*)quote author: (NSString*)author atIndex: (NSUInteger)index;
- (void)insertQuote: (NSString*)quote atIndex: (NSUInteger)index;
- (NSDictionary*)nextQuote;
- (NSDictionary*)prevQuote;
- (NSUInteger)numberOfFavorites;
- (void)addFavorite: (NSString*)quote author: (NSString*)author;
- (void)removeFavorite: (NSString*)quote author: (NSString*)author;
- (void)removeFavoriteAtIndex: (NSUInteger)index;
- (NSDictionary*)favoriteAtIndex: (NSUInteger)index;
- (BOOL)isFavorite: (NSString*)quote author: (NSString*)author;
- (BOOL)isQuote: (NSString*)quote author: (NSString*)author;

@end
