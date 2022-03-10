import { FoodEntity } from "./food.entity";
import { ReviewEntity } from "./review.entity";
import { OrderEntity } from "./order.entity";
import {
	BaseEntity,
	BeforeInsert,
	Column,
	Entity,
	JoinColumn,
	JoinTable,
	ManyToMany,
	OneToMany,
	OneToOne,
	PrimaryGeneratedColumn,
} from "typeorm";
import { CartEntity } from "./cart.entity";

@Entity("user")
export class UserEntity extends BaseEntity {
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
		name: "email",
		type: "varchar",
		nullable: false,
		unique: true,
	})
	email: string;

	@Column({
		name: "password",
		type: "varchar",
		nullable: false,
	})
	password: string;

	@Column({
		name: "useravatar",
		type: "varchar",
		nullable: true,
	})
	userAvatar: string | null;

	@Column({
		name: "isadmin",
		default: false,
	})
	isAdmin: boolean;

	@OneToMany(() => OrderEntity, (order: OrderEntity) => order.user, {
		cascade: true,
		nullable: true,
	})
	orders: OrderEntity[];

	@ManyToMany(() => FoodEntity, (food: FoodEntity) => food.favUsers, {
		cascade: true,
		nullable: true,
	})
	@JoinTable()
	favorites: FoodEntity[];

	@OneToMany(() => ReviewEntity, (review: ReviewEntity) => review.user, {
		cascade: true,
		nullable: true,
	})
	reviews: ReviewEntity[];

	@OneToOne(() => CartEntity, (cart: CartEntity) => cart.user, {
		cascade: true,
		nullable: true,
	})
	@JoinColumn()
	cart: CartEntity;

	@BeforeInsert()
	emailToLowerCase() {
		this.email = this.email.toLowerCase();
	}
}
