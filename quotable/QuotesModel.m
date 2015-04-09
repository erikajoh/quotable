//
//  QuotesModel.m
//  quotable
//
//  Created by Erika Johnson on 2/25/15.
//  Copyright (c) 2015 Erika Marie Johnson. All rights reserved.
//

#import "QuotesModel.h"

NSString *const QuoteKey = @"quote";
NSString *const AuthorKey = @"author";
NSString *const FavoritesKey = @"favorites";

NSString *const QuotesPlist = @"quotes.plist";
NSString *const FavoritesPlist = @"favorites.plist";

@implementation QuotesModel

- (void)save {
    [self.quotes writeToFile:self.quotesPath atomically:YES];
    [self.favorites writeToFile:self.favoritesPath atomically:YES];
}

+ (instancetype)sharedModel {
    static QuotesModel *_sharedModel = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedModel = [[self alloc] init];
    });
    return _sharedModel;
}

- (id)init {
    self = [super init];
    if (self) {
        self.currentIndex = 0;
        NSArray *paths = NSSearchPathForDirectoriesInDomains(
                        NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        self.quotesPath = [documentsDirectory stringByAppendingPathComponent:QuotesPlist];
        self.favoritesPath = [documentsDirectory stringByAppendingPathComponent:FavoritesPlist];
        self.quotes = [NSMutableArray arrayWithContentsOfFile:_quotesPath];
        self.favorites = [NSMutableArray arrayWithContentsOfFile:_favoritesPath];
        if (!self.quotes) {
            self.quotes = [[NSMutableArray alloc] init];
            [self insertQuote:@"If music be the food of love, play on" author:@"William Shakespeare" atIndex:0];
            [self insertQuote:@"No one can make you feel inferior without your consent" author:@"Eleanor Roosevelt" atIndex:1];
            [self insertQuote:@"You are the music while the music lasts" author:@"T.S. Eliot" atIndex:2];
            [self insertQuote:@"Be the change you wish to see in the world" author:@"Mahatma Gandhi" atIndex:3];
            [self insertQuote:@"Life is about creating yourself" author:@"George Bernard Shaw" atIndex:4];
        }
        if (!self.favorites) {
            self.favorites = [[NSMutableArray alloc] init];
        }
    }
    return self;
}

- (NSDictionary*)randomQuote {
    if ([self numberOfQuotes] == 0) return nil;
    if ([self numberOfQuotes] == 1) {
        _currentIndex = 0;
    } else {
        NSUInteger temp = _currentIndex;
        while (_currentIndex == temp)
            _currentIndex = arc4random() % [self numberOfQuotes];
    }
    return [self.quotes objectAtIndex:self.currentIndex];
}

- (NSUInteger)numberOfQuotes {
    return [self.quotes count];
}

- (NSDictionary*)quoteAtIndex: (NSUInteger)index {
    if ([self numberOfQuotes] == 0) return nil;
    if (index >= [self numberOfQuotes]) return nil;
    return [self.quotes objectAtIndex:index];
}

- (void)removeQuoteAtIndex: (NSUInteger)index {
    if ([self numberOfQuotes] == 0) return;
    if (index >= [self numberOfQuotes]) return;
    [self removeFavorite:[self quoteAtIndex:index]];
    [self.quotes removeObjectAtIndex:index];
    [self save];
}

- (void)insertQuote: (NSString*)quote author: (NSString*)author atIndex: (NSUInteger)index {
    if (index > [self numberOfQuotes]) return;
    NSDictionary* newQuote = @{@"quote":quote, @"author":author};
    [self.quotes insertObject:newQuote atIndex:index];
    [self save];
}

- (void)insertQuote: (NSString*)quote atIndex: (NSUInteger)index {
    if (index > [self numberOfQuotes]) return;
    NSDictionary* newQuote = @{@"quote":quote, @"author":@""};
    [self.quotes insertObject:newQuote atIndex:index];
    [self save];
}

- (NSDictionary*)nextQuote {
    if ([self numberOfQuotes] == 0) return nil;
    if (self.currentIndex >= [self numberOfQuotes] - 1) self.currentIndex = 0;
    else self.currentIndex++;
    return [self.quotes objectAtIndex:self.currentIndex];
}

- (NSDictionary*)prevQuote {
    if ([self numberOfQuotes] == 0) return nil;
    if (self.currentIndex <= 0) self.currentIndex = [self numberOfQuotes] - 1;
    else self.currentIndex--;
    return [self.quotes objectAtIndex:self.currentIndex];
}

- (void)addFavorite: (NSString*)quote author: (NSString*)author {
    NSDictionary* newQuote = @{@"quote":quote, @"author":author};
    if ([self.favorites containsObject:newQuote]) return;
    [self.favorites addObject:newQuote];
    [self save];
}

- (void)removeFavoriteAtIndex: (NSUInteger)index {
    [self.favorites removeObjectAtIndex:index];
    [self save];
}

- (void)removeFavorite: (NSString*)quote author: (NSString*)author {
    NSDictionary* newQuote = @{@"quote":quote, @"author":author};
    if ([self.favorites containsObject:newQuote])
        [self.favorites removeObject:newQuote];
    [self save];
}

- (void)removeFavorite: (NSDictionary*)quote {
    if ([self.favorites containsObject:quote])
        [self.favorites removeObject:quote];
    [self save];
}

- (NSUInteger)numberOfFavorites {
    return [self.favorites count];
}

- (NSDictionary*)favoriteAtIndex: (NSUInteger)index {
    if ([self numberOfFavorites] == 0) return nil;
    if (index >= [self numberOfFavorites]) return nil;
    return [self.favorites objectAtIndex:index];
}

- (BOOL)isFavorite: (NSString*)quote author: (NSString*)author {
    NSDictionary* newQuote = @{@"quote":quote, @"author":author};
    if ([self.favorites containsObject:newQuote]) return true;
    else return false;
}

- (BOOL)isQuote: (NSString*)quote author: (NSString*)author {
    NSDictionary* newQuote = @{@"quote":quote, @"author":author};
    if ([self.quotes containsObject:newQuote]) return true;
    else return false;
}

@end
