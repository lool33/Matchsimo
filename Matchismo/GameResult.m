//
//  GameResult.m
//  Matchismo
//
//  Created by Laurent GAIDON on 13/02/13.
//  Copyright (c) 2013 Laurent GAIDON. All rights reserved.
//

#import "GameResult.h"

#define ALL_RESULT_KEY @"GameResult_ALL"
#define START_KEY @"Start"
#define END_KEY @"end"
#define SCORE_KEY @"score"
#define GAME_TYPE_KEY @"GameType"


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
        _gameType = @"undefinedGame";
        
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
    
    //if nothing in userdefault create one dictionnary to store the things in it
    if(!mutableGameResultsFromUserDefault) mutableGameResultsFromUserDefault = [[NSMutableDictionary alloc]init];
    
    //put the score into the dictionnary as a property list
    //use the start property description as the key for the dictionnary (the description is return by the NSdate class)
    
    mutableGameResultsFromUserDefault[[self.startGame description]] = [self asPropertyList];
    
    [[NSUserDefaults standardUserDefaults] setObject:mutableGameResultsFromUserDefault forKey:ALL_RESULT_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}



-(id)asPropertyList
{
 
    return @{START_KEY : self.startGame,END_KEY : self.endGame, SCORE_KEY : @(self.score),GAME_TYPE_KEY : self.gameType};
}


+(NSArray *)allGameResults
{
    NSMutableArray *allGameResults = [[NSMutableArray alloc]init];
    
    for(id plist in [[[NSUserDefaults standardUserDefaults]objectForKey:ALL_RESULT_KEY] allValues])
    {
        GameResult *result = [[GameResult alloc]initFromPropertyList:plist];
        [allGameResults addObject:result];
        
    }
    
    return allGameResults;
    
}

+(void)resetAllScores
{
    //Reset the score by putting an empty dictionnary in the user defaults
    NSMutableDictionary *emptyDictionnary = [[NSMutableDictionary alloc]init];
    [[NSUserDefaults standardUserDefaults] setObject:emptyDictionnary forKey:ALL_RESULT_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

//convenience initializer
-(id)initFromPropertyList:(id)propertyList
{
    self = [self init];
    if(self){
        if([propertyList isKindOfClass:[NSDictionary class]])
        {
            NSDictionary *resultDictionnary = (NSDictionary *)propertyList;
            _startGame = resultDictionnary[START_KEY];
            _endGame = resultDictionnary[END_KEY];
            _score = [resultDictionnary[SCORE_KEY] intValue];
            _gameType = resultDictionnary[GAME_TYPE_KEY];
            if(!_startGame || !_endGame) self = nil;
            
            
        }
        
    }
    return self;
}


@end
