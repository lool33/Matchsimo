//
//  SetMatchingGame.m
//  Matchismo
//
//  Created by Laurent GAIDON on 09/02/13.
//  Copyright (c) 2013 Laurent GAIDON. All rights reserved.
//

#import "SetMatchingGame.h"

@implementation SetMatchingGame

//override the super class's method
-(void)flipCardAtIndex:(NSUInteger)index
{

    //1-retrieve the card passed from the index
    Card *card = [self cardAtIndex:index];
    
    //We create a dicitionnary to store the result of the flip and then save it into the flipHistory
    NSDictionary *flipResult = nil;
    
    //2-check if it's playable
    if(!card.isUnPlayable){
        
        //3-check if it's not already facedUp
        if(!card.isFaceUp){
            
            //we instanciate a Mutable array to store the other card returned
            NSMutableArray *otherCardFacedUp = [[NSMutableArray alloc]init];
            
            
            //4-if not we check if turning this card faced up create a match
            //So we check if there is some other car already faced up
            for (Card *otherCard in self.cards) {
                if(otherCard.isFaceUp && !otherCard.isUnPlayable)
                {
                    [otherCardFacedUp addObject:otherCard];
                }
            }
            
            //check for the number of cards returned and check for a mach is there is 3 cards returned
            
            if(otherCardFacedUp.count == 2){
                
                //We have 3 cards returned
                //check for a mactch
                //if there is a match so the 3 cards match so make the 3 unplayable and credit the score
                //if there is no match return back the 3 cards
                
                int matchScore = [card match:otherCardFacedUp];
                if(matchScore){
                    //here the 3 cards match
                    //make the cards unplayable
                    Card *firstCard = otherCardFacedUp[0];
                    Card *secondCard = otherCardFacedUp[1];
                    card.unPlayable = YES;
                    firstCard.unPlayable = YES;
                    secondCard.unPlayable = YES;
                    
                    //credit the score
                    self.score += matchScore * MATCH_BONUS_3_CARDS;
                    
                    //create the flip result string for a match (ex:@"you matched card & card for X points!")
                    flipResult = @{FIRST_CARD : card,SECOND_CARD : secondCard,THIRD_CARD : firstCard,MATCH_SCORE : @(matchScore * MATCH_BONUS_3_CARDS),MISMATCH : @"NO"};
                    
                }else{
                    //here the 3 cards doesn't match
                    Card *firstCard = otherCardFacedUp[0];
                    Card *secondCard = otherCardFacedUp[1];
                    
                    //return back the 2 cards
                    firstCard.faceUp = NO;
                    secondCard.faceUp = NO;
                    
                    
                    //debit the score
                    self.score -= MISMATCH_PENALTY;
                    
                    //create the flip result string
                    flipResult = @{FIRST_CARD : card, SECOND_CARD : secondCard, THIRD_CARD : firstCard, MATCH_SCORE : @(MISMATCH_PENALTY), MISMATCH : @"YES"};
                    
                }
                
            }
            
            
            //We didn't find any match or mismatch so it's a unique flip
            if(!flipResult){
                //store the card flipped info
                flipResult = @{FIRST_CARD : card, MATCH_SCORE : @(FLIP_COST),MISMATCH : @"NO"};
                
            }
            
            self.score -= FLIP_COST;
            //we save the flip string to the flipHistory
            [self.flipHistory addObject:flipResult];
            
        }
        
        //Now we flip the card only if there is a single flip
        if([flipResult[MISMATCH] isEqualToString:@"NO"]){
            //We have a single flip
            card.faceUp = !card.isFaceUp;
        }
        
        
        
        self.HistoricIndex ++;
        
    }
    
}

-(BOOL)gameIsOver
{
    BOOL gameOver = YES;
    
    for (Card *card1 in self.cards) { //iterate over all the cards of the deck
        if(!card1.isUnPlayable) //continue only if the card is playable
        {
            for (Card *card2 in self.cards) {
                if(!card2.isUnPlayable && !(card1 == card2)) //continue only if card2 is also playable and if it's not equal to card1
                {
                    
                     for (Card *card3 in self.cards) {
                         if(!card3.isUnPlayable && !(card3 == card2) && !(card3 == card1)) //the third card is playable and is not equal to the first two ones
                         {
                         
                         if([card3 match:@[card1,card2]]) gameOver = NO;
                         
                         }
                    }
                
                    
                }
            }
            
        }
    }
    
    return gameOver;

}


@end
