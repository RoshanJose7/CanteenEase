import { join } from "path";
import { Module } from "@nestjs/common";
import { TypeOrmModule } from "@nestjs/typeorm";
import { ServeStaticModule } from "@nestjs/serve-static";

import { AuthModule } from "./auth/auth.module";
import { configService } from "./config.service";
import { FoodModule } from "./food/food.module";
import { OrderModule } from "./order/order.module";
import { ReviewModule } from "./review/review.module";
import { CartModule } from "./cart/cart.module";

@Module({
	imports: [
		ServeStaticModule.forRoot({
			rootPath: join(__dirname, "..", "uploads"),
		}),
		AuthModule,
		TypeOrmModule.forRoot(configService.getTypeOrmConfig()),
		FoodModule,
		OrderModule,
		ReviewModule,
		CartModule,
	],
})
export class AppModule {}
