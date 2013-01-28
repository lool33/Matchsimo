//
//  playingDeck.m
//  Matchismo
//
//  Created by Laurent GAIDON on 28/01/13.
//  Copyright (c) 2013 Laurent GAIDON. All rights reserved.
//

#import "playingDeck.h"
#import "playingCard.h"

@implementation playingDeck


-(id)init
{
    self = [super init];
    
    if(self){
    
        for (NSString *suit in [playingCard validSuits]) {
            for (NSUInteger rank = 1; rank <= [playingCard maxRank]; rank++) {
                playingCard *card = [[playingCard alloc]init];
                card.suit = suit;
                card.rank = rank;
                [self addCard:card onTop:YES];
            }
        }
        
    }
    
    return self;
}

@end
