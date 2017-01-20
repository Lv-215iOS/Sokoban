//
//  Player+CoreDataProperties.m
//  Sokoban
//
//  Created by pasik_01 on 20.01.17.
//
//

#import "Player+CoreDataProperties.h"

@implementation Player (CoreDataProperties)

+ (NSFetchRequest<Player *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Player"];
}

@dynamic name;
@dynamic score;
@dynamic levels;

@end
