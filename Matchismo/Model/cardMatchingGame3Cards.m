//
//  cardMatchingGame3Cards.m
//  Matchismo
//
//  Created by Laurent GAIDON on 02/02/13.
//  Copyright (c) 2013 Laurent GAIDON. All rights reserved.
//

#import "cardMatchingGame3Cards.h"
#import "playingCard.h"

@implementation cardMatchingGame3Cards


-(void)flipCardAtIndex:(NSUInteger)index
{
    
    //1-retrieve the card passed from the index
    Card *card = [self cardAtIndex:index];
    
    //2-check if it's playable
    if(!card.isUnPlayable){
        
        
        //3-check if it's not already facedUp
        if(!card.isFaceUp){
          
            //We create a string to store the result of the flip and then save it into the flipHistory
            NSString *flipResult = nil;
            
            
            //4-if not we check if turning this card faced up create a match
            //So we check if there is some other car already faced up
           
            
            
            
            
            
        }

        
    }
        
    
    //So we check if there is other cards already returned
    //but we have to managed the fact that it could have 2 other cards returned
    //this is managed by the playingCard's method match:(NSArray *)otherCards


    
}


@end
