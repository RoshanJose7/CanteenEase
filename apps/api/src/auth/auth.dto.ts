export class LoginDTO {
	email: string;
	password: string;
}

export class SignupDTO {
	name: string;
	email: string;
	password: string;
	isAdmin?: boolean;
}
