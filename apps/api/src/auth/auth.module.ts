import { UserEntity } from "../entities/user.entity";
import { AuthService } from "./auth.service";
import { Logger, Module } from "@nestjs/common";
import { AuthController } from "./auth.controller";
import { TypeOrmModule } from "@nestjs/typeorm";

@Module({
	imports: [TypeOrmModule.forFeature([UserEntity])],
	controllers: [AuthController],
	providers: [AuthService, Logger],
	exports: [AuthService],
})
export class AuthModule {}
