const API_BASE_URL = 'http://localhost:4000/api'; // Ajuste para o endpoint correto da sua API

// Funções genéricas para chamadas HTTP
async function fetchAPI(endpoint, method = 'GET', body = null) {
    const headers = {
        'Content-Type': 'application/json',
    };

    const options = {
        method,
    };

    if (body) {
        options.headers = {
          'Content-Type': 'application/json',
        };
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
    getAll: () => fetchAPI('/carousels'),
    getById: (id) => fetchAPI(`/carousels/${id}`),
    create: (carousel) => fetchAPI('/carousels', 'POST', carousel),
    update: (id, carousel) => fetchAPI(`/carousels/${id}`, 'PUT', carousel),
    delete: (id) => fetchAPI(`/carousels/${id}`, 'DELETE'),
};

// Slides API
const SlidesAPI = {
    getAll: () => fetchAPI('/slides'),
    getById: (id) => fetchAPI(`/slides/${id}`),
    create: (slide) => fetchAPI('/slides', 'POST', slide),
    update: (id, slide) => fetchAPI(`/slides/${id}`, 'PUT', slide),
    delete: (id) => fetchAPI(`/slides/${id}`, 'DELETE'),
};

export { CarouselsAPI, SlidesAPI };
