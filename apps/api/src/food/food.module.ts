import { FoodEntity } from "./../entities/food.entity";
import { FoodService } from "./food.service";
import { Logger, Module } from "@nestjs/common";
import { FoodController } from "./food.controller";
import { TypeOrmModule } from "@nestjs/typeorm";
import { AuthModule } from "src/auth/auth.module";

@Module({
	imports: [AuthModule, TypeOrmModule.forFeature([FoodEntity])],
	controllers: [FoodController],
	providers: [FoodService, Logger],
	exports: [FoodService],
})
export class FoodModule {}
