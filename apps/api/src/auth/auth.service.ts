import { FoodEntity } from "src/entities/food.entity";
import { HttpException, HttpStatus, Injectable, Logger } from "@nestjs/common";
import { InjectRepository } from "@nestjs/typeorm";
import { Repository } from "typeorm";
import { genSalt, hash, compare } from "bcrypt";

import { LoginDTO, SignupDTO } from "./auth.dto";
import { UserEntity } from "../entities/user.entity";
import { ResponseDTO } from "src/global.dto";
import { configService } from "../config.service";
import { ToggleFavoriteDTO } from "src/food/food.dto";

@Injectable()
export class AuthService {
	constructor(
		@InjectRepository(UserEntity)
		private userRepository: Repository<UserEntity>,
		private logger: Logger,
	) {}

	async getUsers(id?: string): Promise<UserEntity | UserEntity[]> {
		try {
			if (id)
				return await this.userRepository.findOneOrFail(id, {
					relations: ["orders", "reviews", "favorites", "cart"],
				});

			return await this.userRepository.find({
				relations: ["orders", "reviews", "favorites", "cart"],
			});
		} catch (e) {
			this.logger.error(e);
			throw new HttpException(
				"Error finding User!",
				HttpStatus.BAD_REQUEST,
			);
		}
	}

	async login(loginDto: LoginDTO) {
		const user = await this.userRepository.findOne({
			where: {
				email: loginDto.email,
			},
			relations: ["orders", "reviews", "favorites", "cart"],
		});

		if (user) {
			const res = await compare(loginDto.password, user.password);

			if (res)
				return {
					message: "Logged in!",
					user: user,
					statusCode: HttpStatus.ACCEPTED,
				};

			return {
				message: "Passwords do not match",
				statusCode: HttpStatus.UNAUTHORIZED,
			};
		} else
			return {
				message: "User not Found",
				statusCode: HttpStatus.NOT_FOUND,
			};
	}

	async signup(signupDto: SignupDTO): Promise<ResponseDTO> {
		try {
			const salt = await genSalt(parseInt(configService.getSaltRounds()));
			signupDto.password = await hash(signupDto.password, salt);
			await this.userRepository.insert(signupDto);

			return {
				message: "Account Created Successfully",
				statusCode: HttpStatus.ACCEPTED,
			};
		} catch (e) {
			this.logger.error(e);
			throw new HttpException(
				"Error Creating Account!",
				HttpStatus.CONFLICT,
			);
		}
	}

	async deleteUser(id: string): Promise<ResponseDTO> {
		try {
			await this.userRepository.delete(id);

			return {
				message: "User Delete Successfully",
				statusCode: HttpStatus.ACCEPTED,
			};
		} catch (e) {
			this.logger.error(e);
			throw new HttpException("Error Delete User!", HttpStatus.CONFLICT);
		}
	}

	async deleteUsers(): Promise<ResponseDTO> {
		try {
			await this.userRepository.query(`TRUNCATE TABLE "user" CASCADE`);

			return {
				message: "Users Cleared Successfully",
				statusCode: HttpStatus.ACCEPTED,
			};
		} catch (e) {
			this.logger.error(e);
			throw new HttpException(
				"Error Clearing Users!",
				HttpStatus.CONFLICT,
			);
		}
	}

	async toggleFavorite(
		toggleFavoriteDto: ToggleFavoriteDTO,
		food: FoodEntity,
	) {
		const user = await this.userRepository.findOne(
			toggleFavoriteDto.userId,
			{
				relations: ["favorites"],
			},
		);

		if (user) {
			if (toggleFavoriteDto.isFav) {
				if (user.favorites) user.favorites.push(food);
				else user.favorites = [food];
				user.save();
			} else {
				const temp = [];

				user.favorites.forEach((val) => {
					if (val.id !== food.id) temp.push(val);
				});

				user.favorites = temp;
				user.save();
			}

			return {
				message: "Favorite Toggled Successfully",
				statusCode: HttpStatus.ACCEPTED,
			};
		} else
			throw new HttpException(
				"Error toggling favorites!",
				HttpStatus.NOT_FOUND,
			);
	}
}
