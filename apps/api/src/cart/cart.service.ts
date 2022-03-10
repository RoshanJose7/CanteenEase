import { HttpException, HttpStatus, Injectable, Logger } from "@nestjs/common";
import { InjectRepository } from "@nestjs/typeorm";
import { CartEntity } from "src/entities/cart.entity";
import { FoodEntity } from "src/entities/food.entity";
import { UserEntity } from "src/entities/user.entity";
import { Repository } from "typeorm";

@Injectable()
export class CartService {
	constructor(
		@InjectRepository(CartEntity)
		private cartRepository: Repository<CartEntity>,
		private logger: Logger,
	) {}

	async getCartItems(user: UserEntity, id?: string) {
		if (id)
			return {
				message: await this.cartRepository.findOne(id, {
					relations: ["user", "foodItems"],
					where: {
						user,
					},
				}),
				statusCode: HttpStatus.ACCEPTED,
			};

		return {
			message: await this.cartRepository.findOne({
				relations: ["user", "foodItems"],
				where: {
					user,
				},
			}),
			statusCode: HttpStatus.ACCEPTED,
		};
	}

	async addCart(user: UserEntity, foodItems: FoodEntity[]) {
		try {
			const cart = this.cartRepository.create({ user, foodItems });
			await this.cartRepository.save(cart);

			return { message: "Cart Created!", statusCode: HttpStatus.CREATED };
		} catch (e) {
			this.logger.error(e);
			throw new HttpException(
				"Error creating cart!",
				HttpStatus.BAD_REQUEST,
			);
		}
	}

	async editCartItems(id: string, foodItems: FoodEntity[]) {
		const order = await this.cartRepository.findOne(id, {
			relations: ["user", "foodItems"],
		});

		if (order) {
			order.foodItems = foodItems;
			const res = await order.save();
			console.log(res);
		} else throw new HttpException("Cart not found!", HttpStatus.NOT_FOUND);

		return { message: "Cart Updated", statusCode: HttpStatus.ACCEPTED };
	}

	async deleteCart(id: string) {
		try {
			await this.cartRepository.delete(id);
			return {
				message: "Cart Deleted",
				statusCode: HttpStatus.ACCEPTED,
			};
		} catch (e) {
			this.logger.error(e);
			throw new HttpException(
				"Error deleting cart!",
				HttpStatus.NOT_FOUND,
			);
		}
	}
}
