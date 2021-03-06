//
//  Player+CoreDataProperties.m
//  Sokoban
//
//  Created by Oleksiy Bilyi on 1/27/17.
//
//

#import "Player+CoreDataProperties.h"

@implementation Player (CoreDataProperties)

+ (NSFetchRequest<Player *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Player"];
}

@dynamic levelsScores;
@dynamic name;
@dynamic score;
@dynamic photo;

@end
