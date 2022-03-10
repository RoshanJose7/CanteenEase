import { FoodEntity } from "./food.entity";
import { UserEntity } from "./user.entity";
import {
	BaseEntity,
	Column,
	Entity,
	ManyToOne,
	PrimaryGeneratedColumn,
} from "typeorm";

@Entity("review")
export class ReviewEntity extends BaseEntity {
	@PrimaryGeneratedColumn("uuid", {
		name: "id",
	})
	id: string;

	@Column({
		name: "review",
		type: "varchar",
		nullable: false,
	})
	review: string;

	@Column({
		name: "rating",
		type: "integer",
		nullable: false,
	})
	rating: number;

	@ManyToOne(() => UserEntity, (user: UserEntity) => user.reviews, {
		onDelete: "CASCADE",
		nullable: false,
	})
	user: UserEntity;

	@ManyToOne(() => FoodEntity, (food: FoodEntity) => food.reviews, {
		onDelete: "CASCADE",
		nullable: false,
	})
	food: FoodEntity;
}
