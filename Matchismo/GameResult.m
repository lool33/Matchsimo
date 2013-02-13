//
//  GameResult.m
//  Matchismo
//
//  Created by Laurent GAIDON on 13/02/13.
//  Copyright (c) 2013 Laurent GAIDON. All rights reserved.
//

#import "GameResult.h"

@interface GameResult ()

//put propoerty read/write internally
@property(readwrite,nonatomic) NSDate *startGame;
@property(readwrite,nonatomic) NSDate *endGame;

@end

@implementation GameResult

//designated initializer
-(id)init
{
    self = [super init];
    
    if(self){
     
        _startGame = [NSDate date];
        _endGame = _startGame;
        
        
    }
    return self;
}

@end
