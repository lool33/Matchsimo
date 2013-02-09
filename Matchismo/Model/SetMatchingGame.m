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
            
            //check for the number of cards returned and perform specific computing for each case
            
            if(otherCardFacedUp.count == 0){
                //no other card returned so single flip so do nothing
            }else {
                if(otherCardFacedUp.count == 1){
                    
                    //we have 2 cards returned, check if they match
                    //If not flip the first card back
                    //if yes, let theim returned to let a chance the user to have a 3 cards match
                    
                    int matchScore = [card match:otherCardFacedUp];
                    if(matchScore){
                        //the first two card match so let theim returned
                    }else{
                        //the first two card doen't match so return the first one
                        
                        Card *firstCard = otherCardFacedUp[0];
                        firstCard.faceUp = NO;
                        
                    }
                    
                    
                }else if (otherCardFacedUp.count == 2){
                    
                    //We have 3 cards returned
                    //check for a mactch
                    //if there is a match so the 3 cards match so make the 3 unplayable and credit the score
                    //if there is no match return back the two first cards and keep the 3rd card returned
                    
                    int matchScore = [card match:otherCardFacedUp];
                    if(matchScore){
                        //here the 3 cards match
                        //make the cards unplayable
                        Card *firstCard = otherCardFacedUp[0];
                        Card *secondCard = otherCardFacedUp[1];
                        card.unPlayable = YES;
                        firstCard.unPlayable = YES;
                        secondCard.unPlayable = YES;
                        
                        self.score += matchScore * MATCH_BONUS_3_CARDS;
                        
                       
                        //create the flip result string for a match (ex:@"you matched card & card for X points!")
                        flipResult = @{FIRST_CARD : card.contents, SECOND_CARD : secondCard.contents,THIRD_CARD :firstCard.contents  MATCH_SCORE : @(matchScore * MATCH_BONUS_3_CARDS),MISMATCH : @"NO"};
                        
                        
                    }else{
                        //here the 3 cards doesn't match
                        Card *firstCard = otherCardFacedUp[0];
                        Card *secondCard = otherCardFacedUp[1];
                        
                        firstCard.faceUp = NO;
                        secondCard.faceUp = NO;
                        
                        self.score -= MISMATCH_PENALTY;
                        
                        flipResult = @{FIRST_CARD : card.contents,SECOND_CARD : secondCard.contents,THIRD_CARD : firstCard.contents
                        MATCH_SCORE : @(MISMATCH_PENALTY),MISMATCH : @"YES"};
                        
                        
                    }
                    
                }
                
            }
            
            
            //We didn't find any match or mismatch so it's the first flip
            if(!flipResult){
                
                flipResult = @{FIRST_CARD : card.contents, MATCH_SCORE : @(FLIP_COST),MISMATCH : @"NO"};
             
            }
            
            self.score -= FLIP_COST;
            //we save the flip string to the flipHistory
            [self.flipHistory addObject:flipResult];
            
        }
        
        //now we flip the card
        card.faceUp = !card.isFaceUp;
        self.HistoricIndex ++;
        
    }
  
    
    
    
}

@end
