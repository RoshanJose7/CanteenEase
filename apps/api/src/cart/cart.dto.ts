export class CreateCartDTO {
    userId: string;
    foodIds: string[];
}

export class EditCartDTO {
    id: string;
    foodIds: string[];
}