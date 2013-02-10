//
//  SetDeck.m
//  Matchismo
//
//  Created by Laurent GAIDON on 09/02/13.
//  Copyright (c) 2013 Laurent GAIDON. All rights reserved.
//

#import "SetDeck.h"
#import "SetCard.h"

@implementation SetDeck


-(id)init
{
    self = [super init];
    
    if(self){
       //here we make the deck by iterating each card property:
        
        for (NSString *color in [SetCard validColors]) {
            for (NSString *shape in [SetCard validShadings]) {
                for(NSString *symbol in [SetCard validSymbols]){
                    for (int number = 1; number <= [SetCard maxNumber]; number ++) {
                        SetCard *setCard = [[SetCard alloc]init];
                        setCard.color = color;
                        setCard.shading = shape;
                        setCard.symbol = symbol;
                        setCard.number = number;
                        [self addCard:setCard onTop:YES];
                        
                    }
                }
            }
        }
        
    }

    return self;
}

@end
