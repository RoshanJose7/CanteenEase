import { createReviewDTO, editReviewDTO } from "./review.dto";
import { ReviewEntity } from "./../entities/review.entity";
import { HttpException, HttpStatus, Injectable, Logger } from "@nestjs/common";
import { InjectRepository } from "@nestjs/typeorm";
import { Repository } from "typeorm";
import { UserEntity } from "src/entities/user.entity";
import { FoodEntity } from "src/entities/food.entity";

@Injectable()
export class ReviewService {
	constructor(
		@InjectRepository(ReviewEntity)
		private reviewRepository: Repository<ReviewEntity>,
		private logger: Logger,
	) {}

	async getReviews(user?: UserEntity) {
		if (user) {
			return {
				message: await this.reviewRepository.find({
					relations: ["food", "user"],
					where: {
						user,
					},
				}),
				statusCode: HttpStatus.FOUND,
			};
		}

		return {
			message: await this.reviewRepository.find({
				relations: ["food", "user"],
			}),
			statusCode: HttpStatus.FOUND,
		};
	}

	async createReview(
		createReviewDto: createReviewDTO,
		foodItem: FoodEntity,
		user: UserEntity,
	) {
		try {
			const review = this.reviewRepository.create({
				food: foodItem,
				user,
				review: createReviewDto.review,
				rating: createReviewDto.rating,
			});

			await this.reviewRepository.save(review);
			console.log(review);
			return { message: "Review Added", statusCode: HttpStatus.OK };
		} catch (e) {
			this.logger.error(e);
			throw new HttpException(
				"Error Adding Review!",
				HttpStatus.BAD_REQUEST,
			);
		}
	}

	async editReview(editReviewDto: editReviewDTO) {
		const review = await this.reviewRepository.findOne(editReviewDto.id);

		if (review) {
			review.review = editReviewDto.review;
			review.rating = editReviewDto.rating;
			review.save();
		} else
			throw new HttpException("Review not found!", HttpStatus.NOT_FOUND);

		return { message: "Review Updated", statusCode: HttpStatus.ACCEPTED };
	}

	async deleteReview(id: string) {
		try {
			await this.reviewRepository.delete(id);
			return {
				message: "Review Deleted",
				statusCode: HttpStatus.ACCEPTED,
			};
		} catch (e) {
			this.logger.error(e);
			throw new HttpException(
				"Error deleting Review!",
				HttpStatus.NOT_FOUND,
			);
		}
	}
}
