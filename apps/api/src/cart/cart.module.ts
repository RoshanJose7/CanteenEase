import { Module, Logger } from "@nestjs/common";
import { TypeOrmModule } from "@nestjs/typeorm";
import { AuthModule } from "src/auth/auth.module";
import { FoodModule } from "src/food/food.module";
import { CartController } from "./cart.controller";
import { CartService } from "./cart.service";
import { CartEntity } from "./../entities/cart.entity";

@Module({
	imports: [AuthModule, FoodModule, TypeOrmModule.forFeature([CartEntity])],
	controllers: [CartController],
	providers: [CartService, Logger],
})
export class CartModule {}
