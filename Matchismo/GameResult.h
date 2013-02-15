//
//  GameResult.h
//  Matchismo
//
//  Created by Laurent GAIDON on 13/02/13.
//  Copyright (c) 2013 Laurent GAIDON. All rights reserved.
//

#import <Foundation/Foundation.h>




@interface GameResult : NSObject

@property(readonly,nonatomic) NSDate *startGame;
@property(readonly,nonatomic) NSDate *endGame;
@property(readonly, nonatomic) NSTimeInterval duration;

@property(strong,nonatomic) NSString *gameType;
@property(nonatomic) int score; //read/write because we could change the score at anytime


+(NSArray *)allGameResults;//of any kind game result
+(NSArray *)allGameResultsForKindOfGame:(NSString *)gameType; //of card game results

+(void)resetAllScores;



-(NSComparisonResult)compareStartGameWithAnotherResult:(GameResult *)otherResult;
-(NSComparisonResult)compareScoreGameWithAnotherResult:(GameResult *)otherResult;
-(NSComparisonResult)compareDurationGameWithAnotherResult:(GameResult *)otherResult;




@end
