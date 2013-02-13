//
//  GameResult.m
//  Matchismo
//
//  Created by Laurent GAIDON on 13/02/13.
//  Copyright (c) 2013 Laurent GAIDON. All rights reserved.
//

#import "GameResult.h"
#define ALL_RESULT_KEY @"GameResult_ALL"

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


-(NSTimeInterval)duration
{
    return [self.endGame timeIntervalSinceDate:self.startGame];
}

-(void)setScore:(int)score
{
    _score = score;
    self.endGame = [NSDate date];
    [self synchronize];
}

-(void)synchronize
{
    //retrieve the user default
    NSMutableDictionary *mutableGameResultsFromUserDefault = [[[NSUserDefaults standardUserDefaults] dictionaryForKey:ALL_RESULT_KEY] mutableCopy];
    
    //if not create one dictionnary to store the things in it
    if(!mutableGameResultsFromUserDefault) mutableGameResultsFromUserDefault = [[NSMutableDictionary alloc]init];
    
    //put the score into the dictionnary as a property list
    //use the start property description as the key for the dictionnary (the description is return by the NSdate class)
    
    mutableGameResultsFromUserDefault[[self.startGame description]] = [self asPropertyList];
    
    [[NSUserDefaults standardUserDefaults] setObject:mutableGameResultsFromUserDefault forKey:ALL_RESULT_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

#define START_KEY @"Start"
#define END_KEY @"end"
#define SCORE_KEY @"score"

-(id)asPropertyList
{
 
    return @{START_KEY : self.startGame,END_KEY : self.endGame, SCORE_KEY : @(self.score)};
}

@end
