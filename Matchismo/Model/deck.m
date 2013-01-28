//
//  deck.m
//  Matchismo
//
//  Created by Laurent GAIDON on 28/01/13.
//  Copyright (c) 2013 Laurent GAIDON. All rights reserved.
//

#import "deck.h"

@interface deck ()

@property(nonatomic,strong)NSMutableArray *cards;

@end

@implementation deck

-(NSMutableArray *)cards
{
    //lazy instantiation
    if(!_cards) _cards = [[NSMutableArray alloc]init];
    
    return _cards;
    
}


-(void)addCard:(card *)card onTop:(BOOL)ontop
{
    
    if(card){
        
        if(ontop){
            [self.cards insertObject:card atIndex:0];
        
        }else{
            [self.cards addObject:card];
            
        }
    }
    
}

-(card *)drawRandomCard
{
 
    
    
    
    
    
}

@end
