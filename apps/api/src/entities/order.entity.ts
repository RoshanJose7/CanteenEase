import { UserEntity } from "./user.entity";
import {
	BaseEntity,
	Column,
	Entity,
	ManyToOne,
	OneToMany,
	PrimaryGeneratedColumn,
} from "typeorm";
import { FoodEntity } from "./food.entity";
import { PROGRESS } from "src/order/order.dto";

@Entity("order")
export class OrderEntity extends BaseEntity {
	@PrimaryGeneratedColumn("uuid", {
		name: "id",
	})
	id: string;

	@Column({
		name: "price",
		type: "integer",
		nullable: false,
	})
	price: number;

	@Column({
		name: "progress",
		type: "integer",
		default: PROGRESS.PENDING,
	})
	progress: PROGRESS;

	@OneToMany(() => FoodEntity, (food: FoodEntity) => food.order, {
		cascade: true,
	})
	foodItems: FoodEntity[];

	@ManyToOne(() => UserEntity, (user: UserEntity) => user.orders, {
		onDelete: "CASCADE",
		nullable: false,
	})
	user: UserEntity;
}
