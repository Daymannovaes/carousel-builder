import './style.css';
import { getConfiguration, initializeColorPicker } from './settings';
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

const textInput = document.getElementById("textInput")! as HTMLInputElement;
const submitButton = document.getElementById("submitButton")!;
export const displayText = document.getElementById("displayText")!;
const charCounter = document.getElementById("charCounter")!;
const errorMessage = document.getElementById("errorMessage")!;

submitButton.addEventListener("click", () => {
    const text = textInput.value;
    errorMessage.textContent = "";

    if (!text) {
        errorMessage.textContent = "Please enter some text.";
        return;
    }

    const splitItems = splitText(text);

    if (splitItems) {
        const { fontColor, backgroundColor } = getConfiguration();
        displayText.innerHTML = '';
        const listItems = createListItems(splitItems, { fontColor, backgroundColor });
        displayText.append(listItems);
    }

    return;
});

textInput.addEventListener("input", () => {
    charCounter.textContent = `Characters: ${textInput.value.length}`;
});

