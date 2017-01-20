//
//  Player+CoreDataProperties.h
//  Sokoban
//
//  Created by pasik_01 on 20.01.17.
//
//

#import "Player+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Player (CoreDataProperties)

+ (NSFetchRequest<Player *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSNumber *score;

@end

NS_ASSUME_NONNULL_END
