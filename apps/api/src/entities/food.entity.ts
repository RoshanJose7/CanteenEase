import { UserEntity } from "./user.entity";
import { ReviewEntity } from "./review.entity";
import { OrderEntity } from "./order.entity";
import {
	BaseEntity,
	Column,
	Entity,
	ManyToMany,
	ManyToOne,
	OneToMany,
	PrimaryGeneratedColumn,
} from "typeorm";
import { CartEntity } from "./cart.entity";

@Entity("food")
export class FoodEntity extends BaseEntity {
	@PrimaryGeneratedColumn("uuid", {
		name: "id",
	})
	id: string;

	@Column({
		name: "name",
		type: "varchar",
		nullable: false,
		unique: true,
	})
	name: string;

	@Column({
		name: "filepath",
		type: "varchar",
		nullable: false,
		unique: true,
	})
	filepath: string;

	@Column({
		name: "price",
		type: "integer",
		nullable: false,
	})
	price: number;

	@ManyToMany(() => UserEntity, (user: UserEntity) => user.favorites, {
		onDelete: "SET NULL",
	})
	favUsers: UserEntity[];

	@ManyToOne(() => OrderEntity, (order: OrderEntity) => order.foodItems, {
		onDelete: "SET NULL",
	})
	order: OrderEntity;

	@ManyToOne(() => CartEntity, (cart) => cart.foodItems, {
		onDelete: "SET NULL",
	})
	cart: CartEntity;

	@OneToMany(() => ReviewEntity, (review: ReviewEntity) => review.food, {
		onDelete: "SET NULL",
	})
	reviews: ReviewEntity[];
}
