import { Body, Controller, Delete, Get, Patch, Post } from "@nestjs/common";
import { AuthService } from "src/auth/auth.service";
import { UserEntity } from "src/entities/user.entity";
import { FoodService } from "src/food/food.service";
import { CreateCartDTO, EditCartDTO } from "./cart.dto";
import { CartService } from "./cart.service";

@Controller("cart")
export class CartController {
	constructor(
		private readonly foodService: FoodService,
		private readonly cartService: CartService,
		private readonly authService: AuthService,
	) {}

	@Get()
	async getOrders(@Body() userId: string) {
		const user = (await this.authService.getUsers(userId)) as UserEntity;
		return this.cartService.getCartItems(user);
	}

	@Post()
	async createOrder(@Body() createCartDto: CreateCartDTO) {
		const user = (await this.authService.getUsers(
			createCartDto.userId,
		)) as UserEntity;

		const foodItems = await this.foodService.getFoodItems(
			createCartDto.foodIds,
		);

		return this.cartService.addCart(user, JSON.parse(foodItems.foodItems));
	}

	@Patch()
	async editOrder(@Body() editCartDto: EditCartDTO) {
		const foodItems = await this.foodService.getFoodItems(
			editCartDto.foodIds,
		);
		return this.cartService.editCartItems(
			editCartDto.id,
			JSON.parse(foodItems.foodItems),
		);
	}

	@Delete()
	async deleteOrder(@Body() id: string) {
		return this.cartService.deleteCart(id);
	}
}
