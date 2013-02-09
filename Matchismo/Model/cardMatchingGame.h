//
//  cardMatchingGame.h
//  Matchismo
//
//  Created by Laurent GAIDON on 31/01/13.
//  Copyright (c) 2013 Laurent GAIDON. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "playingDeck.h"

#define FLIP_COST 1
#define MATCH_BONUS 4
#define MATCH_BONUS_3_CARDS 5
#define MISMATCH_PENALTY 2
#define FIRST_CARD @"First Card"
#define SECOND_CARD @"Second Card"
#define THIRD_CARD @"Third Card"
#define MATCH_SCORE @"MatchScore"


@interface cardMatchingGame : NSObject

//popertys originaly private but made public to subclass

@property(nonatomic,strong) NSMutableArray *cards; //of cards
@property(nonatomic) int score; //already declared as readOnly in header. So make it read/write in our implementation
//stack to keep the history of flip
@property(nonatomic,strong)NSMutableArray *flipHistory; //first version used for the flip history storing strings

//Store the number of time some card flipped
@property(nonatomic) int HistoricIndex;



//Designated initializer for the game
-(id)initWithCardCount:(NSUInteger)cardCount
             usingDeck:(deck *)deck;

//flip a card of the initialized game at the given index
-(void)flipCardAtIndex:(NSUInteger)index;

//Return a card of the initialized game for the given index
-(Card *)cardAtIndex:(NSUInteger)index;

//the flips are added on the stack, so index 0 is first flip description
-(NSDictionary *)descriptionOfFlipAtIndex:(NSUInteger)index;

//return the description of the mast flip
-(NSDictionary *)descriptionOfLastFlip;

-(BOOL)gameIsOver;



@end
