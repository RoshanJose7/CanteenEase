import { UserEntity } from "./../entities/user.entity";
import { FoodEntity } from "./../entities/food.entity";
import { OrderEntity } from "./../entities/order.entity";
import { HttpException, HttpStatus, Injectable } from "@nestjs/common";
import { Repository } from "typeorm";
import { InjectRepository } from "@nestjs/typeorm";
import { createOrderDTO, editOrderDTO } from "./order.dto";

@Injectable()
export class OrderService {
	constructor(
		@InjectRepository(OrderEntity)
		private orderRepository: Repository<OrderEntity>,
	) {}

	async getOrders(user?: UserEntity) {
		if (user) {
			return {
				message: await this.orderRepository.find({
					relations: ["foodItems", "user"],
					where: {
						user,
					},
				}),
				statusCode: HttpStatus.FOUND,
			};
		}

		return {
			message: await this.orderRepository.find({
				relations: ["foodItems", "user"],
			}),
			statusCode: HttpStatus.FOUND,
		};
	}

	async createOrder(
		createOrderDto: createOrderDTO,
		foodItems: FoodEntity[],
		user: UserEntity,
	) {
		const order = this.orderRepository.create({
			price: createOrderDto.price,
			foodItems,
			user,
		});

		await this.orderRepository.save(order);
		return { message: "Order Created", statusCode: HttpStatus.OK };
	}

	async editOrder(editOrderDto: editOrderDTO) {
		const order = await this.orderRepository.findOne(editOrderDto.id);

		if (order) {
			order.progress = editOrderDto.progress;
			order.save();
		} else
			throw new HttpException("Order not found!", HttpStatus.NOT_FOUND);

		return { message: "Order Updated", statusCode: HttpStatus.ACCEPTED };
	}

	async deleteOrder(id: string) {
		try {
			await this.orderRepository.delete(id);
			return {
				message: "Order Deleted",
				statusCode: HttpStatus.ACCEPTED,
			};
		} catch (e) {
			console.log(e);
			throw new HttpException(
				"Error deleting Order!",
				HttpStatus.NOT_FOUND,
			);
		}
	}
}
