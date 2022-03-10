import { AuthModule } from "./../auth/auth.module";
import { FoodModule } from "./../food/food.module";
import { ReviewEntity } from "./../entities/review.entity";
import { TypeOrmModule } from "@nestjs/typeorm";
import { ReviewService } from "./review.service";
import { Logger, Module } from "@nestjs/common";
import { ReviewController } from "./review.controller";

@Module({
	imports: [AuthModule, FoodModule, TypeOrmModule.forFeature([ReviewEntity])],
	controllers: [ReviewController],
	providers: [ReviewService, Logger],
})
export class ReviewModule {}
