//
//  Player+CoreDataProperties.h
//  Sokoban
//
//  Created by Oleksiy Bilyi on 1/27/17.
//
//

#import "Player+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Player (CoreDataProperties)

+ (NSFetchRequest<Player *> *)fetchRequest;

@property (nullable, nonatomic, retain) NSData *levelsScores;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSNumber *score;
@property (nullable, nonatomic, retain) NSData *photo;

@end

NS_ASSUME_NONNULL_END
