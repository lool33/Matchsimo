//
//  card.h
//  Matchismo
//
//  Created by Laurent GAIDON on 28/01/13.
//  Copyright (c) 2013 Laurent GAIDON. All rights reserved.
//  Class representing a card with a content (suits and rank) and
//  an imageName used for the display of myself

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property(nonatomic,strong)NSString *contents;
@property(nonatomic,readonly)NSString *imageName;

@property(nonatomic,getter=isFaceUp) BOOL faceUp;
@property(nonatomic,getter=isUnPlayable) BOOL unPlayable;

@property(nonatomic,strong)NSAttributedString *contentsAttributed;


-(int)match:(NSArray *)otherCards;


@end