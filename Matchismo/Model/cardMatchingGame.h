//
//  cardMatchingGame.h
//  Matchismo
//
//  Created by Laurent GAIDON on 31/01/13.
//  Copyright (c) 2013 Laurent GAIDON. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "playingDeck.h"

@interface cardMatchingGame : NSObject

//Designated initializer for the game
-(id)initWithCardCount:(NSUInteger)cardCount
             usingDeck:(deck *)deck;

//flip a card of the initialized game at the given index
-(void)flipCardAtIndex:(NSUInteger)index;

//Return a card of the initialized game for the given index
-(Card *)cardAtIndex:(NSUInteger)index;

-(NSString *)descriptionOfFlipAtIndex:(NSUInteger)index;


//score property to store the score game which is publicly readonly
@property(nonatomic,readonly) int score;


//flip result description-bad way should be deleted
@property(nonatomic,strong)NSString *flipResultDescripton;




@end
