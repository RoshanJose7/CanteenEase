export enum PROGRESS {
	PENDING = 1,
	INPROGRESS = 2,
	REAY = 3,
}

export class createOrderDTO {
	userId: string;
	price: number;
	foodIds: string[];
}

export class editOrderDTO {
	id: string;
	progress: PROGRESS;
}
