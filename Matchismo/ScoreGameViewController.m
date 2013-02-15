//
//  ScoreGameViewController.m
//  Matchismo
//
//  Created by Laurent GAIDON on 13/02/13.
//  Copyright (c) 2013 Laurent GAIDON. All rights reserved.
//

#import "ScoreGameViewController.h"
#import "GameResult.h"

@interface ScoreGameViewController () <UITableViewDataSource, UITableViewDelegate>

@property(nonatomic,strong) NSArray *scores; //of score kind of model for this controller
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *scoreTypes;

@end

@implementation ScoreGameViewController

//lazy instantiation of scores
-(NSArray *)scores
{
    if(!_scores) _scores = [[NSArray alloc]init];
        
    return _scores;
    
}

-(void)updateUI
{

    if(self.scoreTypes.selectedSegmentIndex == 0){
        //all games selected
         self.scores = [GameResult allGameResults];
        
    }else if (self.scoreTypes.selectedSegmentIndex == 1){
        //card game result only
    }else{
        //set game result only
    }
   
    [self.tableView reloadData];

}

#pragma mark - ViewLifeCycle

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //do some stuff here about to refetch the score
    [self updateUI];
}


#pragma mark - TableView dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView
numberOfRowsInSection:(NSInteger)section
{
   
    return [self.scores count];
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"scoreCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    GameResult *gameResult = self.scores[indexPath.row];
    
    //display the score
    cell.textLabel.text = [NSString stringWithFormat:@"Score : %d",gameResult.score];
    
    
    //display the start date
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    cell.detailTextLabel.text = [dateFormat stringFromDate:gameResult.startGame];
    
    
    /*
     //display the duration game
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%0g seconds",round(gameResult.duration)];
    */
    return cell;

    
}

#pragma mark - Target/Action

- (IBAction)sortByDate
{
   
    self.scores = [self.scores sortedArrayUsingSelector:@selector(compareStartGameWithAnotherResult:)];
    //self.scores = [[GameResult allGameResults] sortedArrayUsingSelector:@selector(compareStartGameWithAnotherResult:)];
    [self.tableView reloadData];
    
    //sort scoresSortedByDate
    //reset the self.scores array with scoresSortedByDate
    //tableView reload data
}

- (IBAction)sortByScore
{
     self.scores = [self.scores sortedArrayUsingSelector:@selector(compareScoreGameWithAnotherResult:)];
    [self.tableView reloadData];
    
}

- (IBAction)sortByDuration
{
    self.scores = [self.scores sortedArrayUsingSelector:@selector(compareDurationGameWithAnotherResult:)];
    [self.tableView reloadData];
    
}


@end
