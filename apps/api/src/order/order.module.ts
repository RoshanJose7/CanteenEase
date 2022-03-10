import { AuthModule } from "./../auth/auth.module";
import { FoodModule } from "./../food/food.module";
import { OrderEntity } from "./../entities/order.entity";
import { Logger, Module } from "@nestjs/common";
import { TypeOrmModule } from "@nestjs/typeorm";
import { OrderController } from "./order.controller";
import { OrderService } from "./order.service";

@Module({
	imports: [FoodModule, AuthModule, TypeOrmModule.forFeature([OrderEntity])],
	controllers: [OrderController],
	providers: [OrderService, Logger],
})
export class OrderModule {}
