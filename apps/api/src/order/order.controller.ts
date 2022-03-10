import { UserEntity } from "./../entities/user.entity";
import { AuthService } from "./../auth/auth.service";
import { FoodService } from "./../food/food.service";
import { OrderService } from "./order.service";
import { Body, Controller, Delete, Get, Patch, Post } from "@nestjs/common";
import { createOrderDTO, editOrderDTO } from "./order.dto";

@Controller("order")
export class OrderController {
	constructor(
		private readonly foodService: FoodService,
		private readonly orderService: OrderService,
		private readonly authService: AuthService,
	) {}

	@Get()
	async getOrders(@Body() userId: string | null) {
		if (userId) {
			const user = (await this.authService.getUsers(
				userId,
			)) as UserEntity;

			return this.orderService.getOrders(user);
		}

		return this.orderService.getOrders();
	}

	@Post()
	async createOrder(@Body() createOrderDto: createOrderDTO) {
		const user = (await this.authService.getUsers(
			createOrderDto.userId,
		)) as UserEntity;

		const foodItems = await this.foodService.getFoodItems(
			createOrderDto.foodIds,
		);

		return this.orderService.createOrder(
			createOrderDto,
			JSON.parse(foodItems.foodItems),
			user,
		);
	}

	@Patch()
	async editOrder(@Body() editOrderDto: editOrderDTO) {
		return this.orderService.editOrder(editOrderDto);
	}

	@Delete()
	async deleteOrder(@Body() id: string) {
		return this.orderService.deleteOrder(id);
	}
}
