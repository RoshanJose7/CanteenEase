import { UserEntity } from "./user.entity";
import {
	BaseEntity,
	Entity,
	OneToMany,
	OneToOne,
	PrimaryGeneratedColumn,
} from "typeorm";
import { FoodEntity } from "./food.entity";

@Entity("cart")
export class CartEntity extends BaseEntity {
	@PrimaryGeneratedColumn("uuid", {
		name: "id",
	})
	id: string;

	@OneToOne(() => UserEntity, (user) => user.cart, {
		onDelete: "SET NULL",
	})
	user: UserEntity;

	@OneToMany(() => FoodEntity, (food) => food.cart, {
		onDelete: "SET NULL",
	})
	foodItems: FoodEntity[];
}
