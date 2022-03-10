export class AddFoodDTO {
	name: string;
	price: number;
}

export class GetFoodDTO {
	id: string;
}

export class EditFoodDTO {
	id: string;
	name: string;
	price: number;
}

export class ToggleFavoriteDTO {
	foodId: string;
	userId: string;
	isFav: boolean;
}
