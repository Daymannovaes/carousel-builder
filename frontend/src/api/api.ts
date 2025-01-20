import { Carousel } from '../interfaces/carousel';
import { Slide } from '../interfaces/slide';

const API_BASE_URL = 'http://localhost:4000/api'; // TO DO: use environment variable

// Generic function to handle HTTP requests
async function fetchAPI<T>(endpoint: string, method: string = 'GET', body: object | null = null): Promise<T> {
    const headers = {
        'Content-Type': 'application/json',
    };

    const options: RequestInit = {
        method,
        headers,
    };

    if (body) {
        options.body = JSON.stringify(body);
    }

    try {
        const response = await fetch(`${API_BASE_URL}${endpoint}`, options);
        if (!response.ok) {
            throw new Error(`HTTP error! status: ${response.status}`);
        }
        const json = await response.json();
        return json.data ?? json;
    } catch (error) {
        console.error('API fetch error:', error);
        throw error;
    }
}

// Carousels API
const CarouselsAPI = {
    getAll: (): Promise<Carousel[]> => fetchAPI('/carousels'),
    getById: (id: number): Promise<Carousel> => fetchAPI(`/carousels/${id}`),
    create: (carouselData: Carousel): Promise<Carousel> => fetchAPI('/carousels', 'POST', { carousel: carouselData }),
    update: (id: number, carouselData: Carousel): Promise<Carousel> => fetchAPI(`/carousels/${id}`, 'PUT', { carousel: carouselData }),
    delete: (id: number): Promise<void> => fetchAPI(`/carousels/${id}`, 'DELETE'),
};

// Slides API
const SlidesAPI = {
    getAll: (): Promise<Slide[]> => fetchAPI('/slides'),
    getById: (id: number): Promise<Slide> => fetchAPI(`/slides/${id}`),
    create: (slideData: Slide): Promise<Slide> => fetchAPI('/slides', 'POST', { slide: slideData }),
    update: (id: number, slideData: Slide): Promise<Slide> => fetchAPI(`/slides/${id}`, 'PUT', { slide: slideData }),
    delete: (id: number): Promise<void> => fetchAPI(`/slides/${id}`, 'DELETE'),
};

export { CarouselsAPI, SlidesAPI };
