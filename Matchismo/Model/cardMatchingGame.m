//
//  cardMatchingGame.m
//  Matchismo
//
//  Created by Laurent GAIDON on 31/01/13.
//  Copyright (c) 2013 Laurent GAIDON. All rights reserved.
//

#import "cardMatchingGame.h"
#import "playingCard.h"

@interface cardMatchingGame ()

@property(nonatomic,strong) NSMutableArray *cards; //of cards
@property(nonatomic) int score; //already declared as readOnly in header. So make it read/write in our implementation
//stack to keep the history of flip
@property(nonatomic,strong)NSMutableArray *flipHistory; //declared privatly as read/write


@end


@implementation cardMatchingGame


//lazy instantiation of the cards property
-(NSMutableArray *)cards
{
    if(!_cards) _cards = [[NSMutableArray alloc]init];
    return _cards;
}

//lazy instantiation of the historic propoerty
-(NSMutableArray *)flipHistory
{
    if(!_flipHistory) _flipHistory = [[NSMutableArray alloc]init];
    return _flipHistory;
}


//implementation of the designated initializer
-(id)initWithCardCount:(NSUInteger)cardCount
             usingDeck:(deck *)deck
{
    self = [super init];
    //checking for correct super init
    if(self)
    {
        //iteration over the number of card
        for (int i = 0; i < cardCount; i++) {
            //asking a random card to the deck
            Card *card = [deck drawRandomCard];
            //check if the card exist to avoid ading nil in our array that will crash the app
            if(!card)
            {
                //We return nil if we can't initialize ourself
                self = nil;
                
            }else{
                //if we have a correct card then add it to our poperty
                self.cards[i] = card;
            }
        }
        
    }
    
    return self;
}

#define FLIP_COST 1
#define MATCH_BONUS 4
#define MISMATCH_PENALTY 2

//this method is the heart of the game logic
-(void)flipCardAtIndex:(NSUInteger)index
{
  
    //starting by grabbing the card we are interested in
    Card *card = [self cardAtIndex:index];
    
    
    
    //check if it's playable
    if(!card.isUnPlayable)
    {
        if(!card.isFaceUp)
        {
            BOOL multipleFlip = NO;
            //we check if turning this card faced up create a match
            //So we check if there is other cards already returned
            for (Card *otherCard in self.cards) {
                if(otherCard.isFaceUp && !otherCard.isUnPlayable)
                {
                    //and we check if the cards are matching in some sense
                    int matchScore = [card match:@[otherCard]];
                    
                    //if there is a match, update the score and makes the card unplayable
                    if(matchScore)
                    {
                        card.unPlayable = YES;
                        otherCard.unPlayable = YES;
                        multipleFlip = YES;
                        //as Paul says, we scale the matchScore to a modifiable value
                        self.score += matchScore * MATCH_BONUS;
                        [self.flipHistory addObject:@[@"match",card,otherCard]];
                        
                        
                    }else{
                        otherCard.faceUp = NO;
                        multipleFlip = YES;
                        self.score -= MISMATCH_PENALTY;
                        [self.flipHistory addObject:@[@"mismatch",card,otherCard]];
                        
                    }
                    
                    break;
                }
                
                
            }
            
            if(!multipleFlip){
                [self.flipHistory addObject:@[card]];
            }
            
            self.score -= FLIP_COST;
            
        }
        
        
        //now we flip the card
        card.faceUp = !card.isFaceUp;
        
    }
    
}




//We return the card for the given index after checking that the index is not out of bounds
-(Card *)cardAtIndex:(NSUInteger)index
{
    return (index < self.cards.count) ? self.cards[index] : nil;
    
}


-(NSString *)descriptionOfFlipAtIndex:(NSUInteger)index
{
 
    NSString *description = nil;
    
    if(index <= self.flipHistory.count){
        NSArray *playedCards = self.flipHistory[index];

        
    if(playedCards.count == 0){
        description = nil;
        
    }else if (playedCards.count == 1){
    //It's a single flip
        Card *singleCard = [playedCards lastObject];
        description = [NSString stringWithFormat:@"Flipped up %@",singleCard.contents];
    }else {
        
        if ([playedCards[0] isEqualToString:@"mismatch"]) {
            //We are in a mismatch case
            Card *firstCard = playedCards[1];
            Card *secondCard = playedCards[2];
            description = [NSString stringWithFormat:@"%@ & %@ doesn't match! 2 points penalty!",firstCard.contents,secondCard.contents];
            
        }else {
            //We are in a case of match
            playingCard *firstCard = playedCards[1];
            playingCard *secondCard = playedCards[2];
            
            if(firstCard.rank == secondCard.rank){
                //it's a rank match
                
            description = [NSString stringWithFormat:@"Matched %@ & %@ for %d points",firstCard.contents,secondCard.contents, SCORE_FOR_MATCH_RANK * MATCH_BONUS];
                
            }else {
                //it's a suit match
                description = [NSString stringWithFormat:@"Matched %@ & %@ for %d points",firstCard.contents,secondCard.contents,SCORE_FOR_MATCH_SUIT * MATCH_BONUS];
            }
            
        }
        
        
    }
    
}
    return description;
}



@end
