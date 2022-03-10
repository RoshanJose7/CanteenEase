import { TypeOrmModuleOptions } from "@nestjs/typeorm";
import { ReviewEntity } from "./entities/review.entity";
import { OrderEntity } from "./entities/order.entity";
import { FoodEntity } from "./entities/food.entity";
import { UserEntity } from "./entities/user.entity";
import { CartEntity } from "./entities/cart.entity";

// eslint-disable-next-line @typescript-eslint/no-var-requires
require("dotenv").config({
	path: process.env.NODE_ENV.trim() === "DEV" ? ".env.dev" : ".env.prod",
});

class ConfigService {
	constructor(private env: { [k: string]: string | undefined }) {}

	private getValue(key: string, throwOnMissing = true): string {
		const value = this.env[key];

		if (!value && throwOnMissing) {
			throw new Error(`config error - missing env.${key}`);
		}

		return value;
	}

	public ensureValues(keys: string[]) {
		keys.forEach((k) => this.getValue(k, true));
		return this;
	}

	public getPort() {
		return this.getValue("PORT", true);
	}

	public getSaltRounds() {
		return this.getValue("SALT_ROUNDS", true);
	}

	public isProduction() {
		const mode = this.getValue("MODE", false);
		return mode != "DEV";
	}

	public getTypeOrmConfig(): TypeOrmModuleOptions {
		return {
			type: "postgres",
			host: this.getValue("POSTGRES_HOST"),
			port: parseInt(this.getValue("POSTGRES_PORT")),
			username: this.getValue("POSTGRES_USER"),
			password: this.getValue("POSTGRES_PASSWORD"),
			database: this.getValue("POSTGRES_DATABASE"),
			entities: [
				UserEntity,
				FoodEntity,
				OrderEntity,
				ReviewEntity,
				CartEntity,
			],
			synchronize: !this.isProduction(),
			ssl: true,
		};
	}
}

const configService = new ConfigService(process.env).ensureValues([
	"POSTGRES_HOST",
	"POSTGRES_PORT",
	"POSTGRES_USER",
	"POSTGRES_PASSWORD",
	"POSTGRES_DATABASE",
]);

export { configService };
