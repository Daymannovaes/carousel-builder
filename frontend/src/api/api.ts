const API_BASE_URL = 'http://localhost:4000/api'; // TO DO: use environment variable

interface Carousel {
    id: number;
    background_color: string;
    font_color: string;
    position: number;
    quill_delta_content: string;
}

interface Slide {
    id: number;
    background_color: string;
    font_color: string;
    position: number;
    quill_delta_content: string;
    carousel_id: number;
}

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
        return await response.json();
    } catch (error) {
        console.error('API fetch error:', error);
        throw error;
    }
}

// Carousels API
const CarouselsAPI = {
    getAll: (): Promise<Carousel[]> => fetchAPI('/carousels'),
    getById: (id: number): Promise<Carousel> => fetchAPI(`/carousels/${id}`),
    create: (carousel: Carousel): Promise<Carousel> => fetchAPI('/carousels', 'POST', carousel),
    update: (id: number, carousel: Carousel): Promise<Carousel> => fetchAPI(`/carousels/${id}`, 'PUT', carousel),
    delete: (id: number): Promise<void> => fetchAPI(`/carousels/${id}`, 'DELETE'),
};

// Slides API
const SlidesAPI = {
    getAll: (): Promise<Slide[]> => fetchAPI('/slides'),
    getById: (id: number): Promise<Slide> => fetchAPI(`/slides/${id}`),
    create: (slide: Slide): Promise<Slide> => fetchAPI('/slides', 'POST', slide),
    update: (id: number, slide: Slide): Promise<Slide> => fetchAPI(`/slides/${id}`, 'PUT', slide),
    delete: (id: number): Promise<void> => fetchAPI(`/slides/${id}`, 'DELETE'),
};

export { CarouselsAPI, SlidesAPI };
