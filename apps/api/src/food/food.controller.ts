import { AuthService } from "src/auth/auth.service";
import { FoodService } from "./food.service";
import {
	Controller,
	Post,
	Get,
	UseInterceptors,
	Body,
	Patch,
	Delete,
} from "@nestjs/common";
import { FilesInterceptor } from "@nestjs/platform-express";
import { diskStorage } from "multer";
import { AddFoodDTO, EditFoodDTO, ToggleFavoriteDTO } from "./food.dto";
import { ResponseDTO } from "src/global.dto";

let currentFileName = "";

@Controller("food")
export class FoodController {
	constructor(
		private readonly foodService: FoodService,
		private readonly authService: AuthService,
	) {}

	@Get()
	getFoodItems() {
		return this.foodService.getFoodItems();
	}

	@Post()
	@UseInterceptors(
		FilesInterceptor("foodpic", 1, {
			dest: "uploads",
			preservePath: true,
			storage: diskStorage({
				destination: "uploads",
				filename: (_, file, cb) => {
					currentFileName = file.originalname;
					cb(null, file.originalname);
				},
			}),
		}),
	)
	addFoodItem(@Body() addFoodDto: AddFoodDTO): Promise<ResponseDTO> {
		return this.foodService.addFoodItem(addFoodDto, currentFileName);
	}

	@Patch("favorite")
	async toggleFavorite(@Body() toggleFavoriteDto: ToggleFavoriteDTO) {
		const food = await this.foodService.getFoodItem(
			toggleFavoriteDto.foodId,
		);

		return await this.authService.toggleFavorite(
			toggleFavoriteDto,
			food.foodItem,
		);
	}

	@Patch()
	@UseInterceptors(
		FilesInterceptor("foodpic", 1, {
			dest: "uploads",
			preservePath: true,
			storage: diskStorage({
				destination: "uploads",
				filename: (_, file, cb) => {
					currentFileName = file.originalname;
					cb(null, file.originalname);
				},
			}),
		}),
	)
	editFoodItem(@Body() editFoodDto: EditFoodDTO): Promise<ResponseDTO> {
		return this.foodService.editFoodItem(editFoodDto, currentFileName);
	}

	@Delete()
	deleteFood(@Body() id: string): Promise<ResponseDTO> {
		return this.foodService.delete(id);
	}

	@Delete("truncate")
	truncateTable(): Promise<ResponseDTO> {
		return this.foodService.truncateTable();
	}
}
