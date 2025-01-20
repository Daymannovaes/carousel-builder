import './style.css';
import { CarouselsAPI } from './api/api';
import { Carousel } from './interfaces/carousel';
import { Slide } from './interfaces/slide';
import { getConfiguration, getFormattedDate, initializeColorPicker } from './settings';
import { splitText } from './utils/split-text';
import { CarouselSlide } from './carousel-slide';
import { createListItems } from './utils/create-list-items';
import { testBackendConnection } from './utils/testConnection';

testBackendConnection();

if (!customElements.get("carousel-slide")) {
    customElements.define("carousel-slide", CarouselSlide);
}

initializeColorPicker({
    fontColorButton: document.getElementById("fontColorButton") as HTMLElement,
    fontColorInput: document.getElementById("fontColor") as HTMLInputElement,
    fontColorPreview: document.getElementById("fontColorPreview") as HTMLElement,
    backgroundColorButton: document.getElementById("backgroundColorButton") as HTMLElement,
    backgroundColorInput: document.getElementById("backgroundColor") as HTMLInputElement,
    backgroundColorPreview: document.getElementById("backgroundColorPreview") as HTMLElement
});

async function listCarousels() {
    try {
        displayText.innerHTML = "";
        const carousels: Carousel[] = await CarouselsAPI.getAll();

        carousels.forEach(carousel => {
            const slide_text: string[] = carousel.slides
                .sort((a, b) => a.position - b.position)
                .map(slide => slide.quill_delta_content);

            const listItems = createListItems(slide_text, {
                fontColor: carousel.slides[0]?.font_color || "#000000ff",
                backgroundColor: carousel.slides[0]?.background_color || "#000000ff"
            });

            displayText.append(listItems);
        });
    } catch (error) {
        console.error("Erro ao buscar dados:", error);
    }
}

async function getCarouselById(id: number) {
    try {
        displayText.innerHTML = "";
        const carousel: Carousel = await CarouselsAPI.getById(id);

        const slide_text: string[] = carousel.slides
            .sort((a, b) => a.position - b.position)
            .map(slide => slide.quill_delta_content);

        const listItems = createListItems(slide_text, {
            fontColor: carousel.slides[0]?.font_color || "#000000ff",
            backgroundColor: carousel.slides[0]?.background_color || "#000000ff"
        });

        displayText.append(listItems);
    } catch (error) {
        console.error("Erro ao buscar dados:", error);
    }
}

async function createCarousel(carousel: Carousel) {
    try {
        displayText.innerHTML = "";
        console.log(carousel);
        const data: Carousel = await CarouselsAPI.create(carousel);

        const slide_text: string[] = data.slides
            .sort((a, b) => a.position - b.position)
            .map(slide => slide.quill_delta_content);

        const listItems = createListItems(slide_text, {
            fontColor: carousel.slides[0]?.font_color || "#000000ff",
            backgroundColor: carousel.slides[0]?.background_color || "#000000ff"
        });

        displayText.append(listItems);
    } catch (error) {
        console.error("Erro ao buscar dados:", error);
    }
}

const textInput = document.getElementById("textInput")! as HTMLInputElement;
const submitButton = document.getElementById("submitButton")!;
const listCarouselsButton = document.getElementById("listCarouselsButton")!;
const carouselIdInput = document.getElementById("carouselIdInput")! as HTMLInputElement;
const getCarouselButton = document.getElementById("getCarouselButton")!;
export const displayText = document.getElementById("displayText")!;
const charCounter = document.getElementById("charCounter")!;
const errorMessage = document.getElementById("errorMessage")!;

submitButton.addEventListener("click", async () => {
    const text = textInput.value;
    errorMessage.textContent = "";

    if (!text) {
        errorMessage.textContent = "Please enter some text.";
        return;
    }

    const splitItems = splitText(text);

    if (splitItems) {
        const configuration = getConfiguration();
        await Promise.all([
            createHtmlCarousel(splitItems, configuration),
            createApiCarousel(splitItems, configuration)
        ]);
    }

    return;
});

const createHtmlCarousel = (splitItems: string[], configuration: any) => {
    displayText.innerHTML = '';
    const listItems = createListItems(splitItems, configuration);
    displayText.append(listItems);
};

const createApiCarousel = async (splitItems: string[], configuration: any) => {
    const slides: Slide[] = splitItems.map((item, index) => ({
        background_color: configuration.backgroundColor as string,
        font_color: configuration.fontColor as string,
        position: index + 1,
        quill_delta_content: item
    }));

    const carousel: Carousel = {
        name: "Carousel " + getFormattedDate(),
        is_active: true,
        slides: slides
    };

    await createCarousel(carousel);
};

listCarouselsButton.addEventListener("click", async () => {
    await listCarousels();

    return;
});

getCarouselButton.addEventListener("click", () => {
    const carouselId = parseInt(carouselIdInput.value);
    if (isNaN(carouselId)) {
        alert("Please, type a valid ID.");
        return;
    }
    getCarouselById(carouselId);

    return;
});

textInput.addEventListener("input", () => {
    charCounter.textContent = `Characters: ${textInput.value.length}`;
});

document.addEventListener("DOMContentLoaded", async () => {
    await listCarousels();

    return;
});
