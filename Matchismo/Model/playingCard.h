//
//  playingCard.h
//  Matchismo
//
//  Created by Laurent GAIDON on 28/01/13.
//  Copyright (c) 2013 Laurent GAIDON. All rights reserved.
//  Class inherited from card class
//  Define the suit and rank of the card
//  Provide API returning the valid suits and ranks allowed

#import "Card.h"

@interface playingCard : Card

@property(nonatomic,strong) NSString *suit;
@property(nonatomic) NSUInteger rank;

+(NSArray *)validSuits;

+(NSUInteger)maxRank;


@end
