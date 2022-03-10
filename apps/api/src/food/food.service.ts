import { rm } from "fs";
import { Repository } from "typeorm";
import { InjectRepository } from "@nestjs/typeorm";
import { HttpException, HttpStatus, Injectable, Logger } from "@nestjs/common";

import { ResponseDTO } from "src/global.dto";
import { FoodEntity } from "../entities/food.entity";
import { AddFoodDTO, EditFoodDTO } from "./food.dto";

@Injectable()
export class FoodService {
	constructor(
		@InjectRepository(FoodEntity)
		private foodRepository: Repository<FoodEntity>,
		private logger: Logger,
	) {}

	async getFoodItems(ids?: string[]) {
		if (ids) {
			const foodItems = [];

			for (let i = 0; i < ids.length; i++) {
				const food = await this.foodRepository.findOne(ids[i]);

				if (food) foodItems.push(food);
				else {
					throw new HttpException(
						`Food Item ${ids[i]} does not exist!`,
						HttpStatus.NOT_FOUND,
					);
				}
			}

			return {
				foodItems: JSON.stringify(foodItems),
				statusCode: HttpStatus.ACCEPTED,
			};
		}

		return {
			foodItems: JSON.stringify(await this.foodRepository.find()),
			statusCode: HttpStatus.ACCEPTED,
		};
	}

	async getFoodItem(id: string) {
		return {
			foodItem: await this.foodRepository.findOne(id),
			statusCode: HttpStatus.ACCEPTED,
		};
	}

	async addFoodItem(
		addFoodDto: AddFoodDTO,
		filePath: string,
	): Promise<ResponseDTO> {
		await this.foodRepository.insert({
			name: addFoodDto.name,
			filepath: filePath,
			price: addFoodDto.price,
		});

		return { message: "Food Item Added", statusCode: HttpStatus.ACCEPTED };
	}

	async editFoodItem(
		editFoodDto: EditFoodDTO,
		newFilePath: string,
	): Promise<ResponseDTO> {
		const foodItem = await this.foodRepository.findOne(editFoodDto.id);

		if (!foodItem) {
			throw new HttpException(
				"Food Item does not exist!",
				HttpStatus.NOT_FOUND,
			);
		}

		foodItem.name = editFoodDto.name;
		foodItem.price = editFoodDto.price;
		foodItem.filepath = newFilePath;

		rm(foodItem.filepath, (err) => {
			if (err) console.log(err);
		});

		foodItem.save();
		return {
			message: "Food Item Updated!",
			statusCode: HttpStatus.ACCEPTED,
		};
	}

	async delete(id: string): Promise<ResponseDTO> {
		const food = await this.foodRepository.findOne(id);
		await this.foodRepository.delete(id);

		if (!food) {
			throw new HttpException(
				"Food does not exist!",
				HttpStatus.NOT_FOUND,
			);
		}

		rm(food.filepath, (err) => {
			if (err) console.log(err);
		});

		return {
			message: "Food Item Deleted!",
			statusCode: HttpStatus.ACCEPTED,
		};
	}

	async truncateTable(): Promise<ResponseDTO> {
		const foodItems = await this.foodRepository.find();
		await this.foodRepository.clear();

		if (!foodItems) {
			throw new HttpException("Table is Empty!", HttpStatus.NOT_FOUND);
		}

		foodItems.forEach((food) => {
			rm(food.filepath, (err) => {
				if (err) console.log(err);
			});
		});

		return { message: "Table Truncated!", statusCode: HttpStatus.ACCEPTED };
	}
}
