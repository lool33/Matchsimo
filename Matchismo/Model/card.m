//
//  card.m
//  Matchismo
//
//  Created by Laurent GAIDON on 28/01/13.
//  Copyright (c) 2013 Laurent GAIDON. All rights reserved.
//

#import "card.h"

@implementation card


//method to check if I'm (self, the instanciated card) the same
//than some cards passed as argument here (otherCards)
-(int)match:(NSArray *)otherCards
{
    
    int score = 0;
    
        for (card *card in otherCards) {
            
            if([card.contents isEqualToString:self.contents])
            {
                score = 1;
            }
            
        }
        

    return score;
}

@end
