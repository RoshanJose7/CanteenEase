export class createReviewDTO {
	userId: string;
	review: string;
	foodId: string;
	rating: number;
}

export class editReviewDTO {
	id: string;
	review: string;
	rating: number;
}
