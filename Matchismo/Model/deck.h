//
//  deck.h
//  Matchismo
//
//  Created by Laurent GAIDON on 28/01/13.
//  Copyright (c) 2013 Laurent GAIDON. All rights reserved.
//  Class that define a deck of cards


#import <Foundation/Foundation.h>
#import "Card.h"

@interface deck : NSObject

//instance method to add cards in the deck
-(void)addCard:(Card *)card onTop:(BOOL)ontop;

//instance method to return a random card from the deck and remove it
-(Card *)drawRandomCard;


@end
