import { UserEntity } from "../entities/user.entity";
import { LoginDTO, SignupDTO } from "./auth.dto";
import { AuthService } from "./auth.service";
import { Body, Controller, Delete, Get, Post, Query } from "@nestjs/common";
import { ResponseDTO } from "src/global.dto";

@Controller("auth")
export class AuthController {
	constructor(private readonly authService: AuthService) {}

	@Get()
	async getUsers(
		@Query("id") id: string | null,
	): Promise<UserEntity | UserEntity[]> {
		return await this.authService.getUsers(id);
	}

	@Post("login")
	login(@Body() loginDto: LoginDTO) {
		return this.authService.login(loginDto);
	}

	@Post("signup")
	signup(@Body() signupDto: SignupDTO): Promise<ResponseDTO> {
		return this.authService.signup(signupDto);
	}

	@Delete("truncate")
	truncate(): Promise<ResponseDTO> {
		return this.authService.deleteUsers();
	}
}
