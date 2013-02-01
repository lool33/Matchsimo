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
                      
                        //as Paul says, we scale the matchScore to a modifiable value
                        self.score += matchScore * MATCH_BONUS;
                        
                    }else{
                        otherCard.faceUp = NO;
                        self.score -= MISMATCH_PENALTY;
                                               
                    }
                    
                    break;
                }
                
                
            }
            
            self.score -= FLIP_COST;
            
        }
        
        
        //now we flip the card
        card.faceUp = !card.isFaceUp;
        //if we flip the card, then we save it to the flipHistory
        [self.flipHistory insertObject:card.contents atIndex:0];
        
    }
    
}




//We return the card for the given index after checking that the index is not out of bounds
-(Card *)cardAtIndex:(NSUInteger)index
{
    return (index < self.cards.count) ? self.cards[index] : nil;
    
}


-(NSString *)descriptionOfLastFlip
{
 
    NSString *description = @"";
    
            //NSMutableArray *playedCards = [[NSMutableArray alloc]init];
        
        NSMutableArray *playedCards = self.flipHistory[0];
        
        if(playedCards){
        
        [playedCards addObject:self.flipHistory[0]];

        
    if([playedCards count] == 0){
        description = nil;
        
    }else if ([playedCards count] == 1){
    //It's a single flip
        
        
        NSString *endsOfDesc = [NSString stringWithFormat:@"Flipped up %@",[playedCards lastObject]];
        description = [description stringByAppendingString:endsOfDesc];
        
    }else {
        
        if ([playedCards[0] isEqualToString:@"mismatch"]) {
            //We are in a mismatch case
            NSString *endsOfDesc = [NSString stringWithFormat:@"%@ & %@ doesn't match! 2 points penalty!",playedCards[1],playedCards[2]];
            description = [description stringByAppendingString:endsOfDesc];
            
        }else {
            //We are in a case of match
            //We need to know if we match the color or the rank
            NSString *firstSuit = [cardMatchingGame suitForContents:playedCards[1]];
            NSString *secondSuit = [cardMatchingGame suitForContents:playedCards[2]];
          
            if([firstSuit isEqualToString:secondSuit]){
                //it's a suit match
                
                NSString *endsOfDesc =[NSString stringWithFormat:@"Matched %@ & %@ for %d points",playedCards[1],playedCards[2],SCORE_FOR_MATCH_SUIT * MATCH_BONUS];
                description = [description stringByAppendingString:endsOfDesc];
                
                
            }else{
                //it's a rank match
                NSString *endsOfDesc = [NSString stringWithFormat:@"Matched %@ & %@ for %d points",playedCards[1],playedCards[2], SCORE_FOR_MATCH_RANK * MATCH_BONUS];
                description = [description stringByAppendingString:endsOfDesc];
                
            }
            
        }
        
        
    }
    }

    return description;
}



//convenient class method to retrieve the suit form the content
+(NSString *)suitForContents:(NSString *)contents
{
    NSString *suit = [contents substringToIndex:1];
    
    if([suit isEqualToString:@"c"]){
        return @"clubs";
    }else if ([suit isEqualToString:@"d"]){
        return @"diamonds";
    }else if ([suit isEqualToString:@"h"]){
        return @"hearts";
    }else if ([suit isEqualToString:@"s"]){
       return @"spades";
    }
    
    return nil;
}

@end
