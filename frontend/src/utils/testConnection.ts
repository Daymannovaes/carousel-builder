interface PingResponse {
    message: string
}

async function testBackendConnection(): Promise<void> {
    try {
        console.log('Testing connection to backend...');

        console.log('Attempting to reach backend at http://localhost:5000/api/ping');
        const response = await fetch('http://localhost:5000/api/ping');

        if (!response.ok) {
            throw new Error(`HTTP error! status: ${response.status}`);
        }

        const data: PingResponse = await response.json();

        if (data.message === 'pong') {
            console.log('Connection test successful! Backend is responding correctly.');
        }

    } catch (error) {
        console.error('Failed to connect to backend', error);

        if (error instanceof TypeError) {
            console.log('Cannot reach the backend server. Is it running?');
        }
    }
}

testBackendConnection();

export { testBackendConnection };