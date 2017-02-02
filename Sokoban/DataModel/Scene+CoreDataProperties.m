//
//  Scene+CoreDataProperties.m
//  Sokoban
//
//  Created by pasik_01 on 20.01.17.
//
//

#import "Scene+CoreDataProperties.h"

@implementation Scene (CoreDataProperties)

+ (NSFetchRequest<Scene *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Scene"];
}

@dynamic height;
@dynamic matrix;
@dynamic width;
@dynamic level;

@end
