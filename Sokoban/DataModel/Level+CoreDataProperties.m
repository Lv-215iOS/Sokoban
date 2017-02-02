//
//  Level+CoreDataProperties.m
//  Sokoban
//
//  Created by pasik_01 on 20.01.17.
//
//

#import "Level+CoreDataProperties.h"

@implementation Level (CoreDataProperties)

+ (NSFetchRequest<Level *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Level"];
}

@dynamic name;
@dynamic order;
@dynamic scene;

@end
