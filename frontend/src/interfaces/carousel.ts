import { Slide } from './slide';

export interface Carousel {
    name: string;
    is_active: boolean;
    slides: Slide[];
}
