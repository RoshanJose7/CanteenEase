import { createReviewDTO, editReviewDTO } from "./review.dto";
import { ReviewService } from "./review.service";
import { Body, Controller, Delete, Get, Patch, Post } from "@nestjs/common";
import { AuthService } from "src/auth/auth.service";
import { UserEntity } from "src/entities/user.entity";
import { FoodService } from "src/food/food.service";

@Controller("review")
export class ReviewController {
	constructor(
		private readonly foodService: FoodService,
		private readonly authService: AuthService,
		private readonly reviewService: ReviewService,
	) {}

	@Get()
	async getReviews(@Body() userId: string | null) {
		if (userId) {
			const user = (await this.authService.getUsers(
				userId,
			)) as UserEntity;

			return this.reviewService.getReviews(user);
		}

		return this.reviewService.getReviews();
	}

	@Post()
	async createReview(@Body() createReviewDto: createReviewDTO) {
		const user = (await this.authService.getUsers(
			createReviewDto.userId,
		)) as UserEntity;

		const foodItem = await this.foodService.getFoodItem(
			createReviewDto.foodId,
		);

		return this.reviewService.createReview(
			createReviewDto,
			foodItem.foodItem,
			user,
		);
	}

	@Patch()
	async editReview(@Body() editReviewDto: editReviewDTO) {
		return this.reviewService.editReview(editReviewDto);
	}

	@Delete()
	async deleteReview(@Body() id: string) {
		return this.reviewService.deleteReview(id);
	}
}
