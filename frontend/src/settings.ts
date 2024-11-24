import Picker from 'vanilla-picker';

const fontColorInput = document.getElementById("fontColor") as HTMLInputElement | null;
const backgroundColorInput = document.getElementById("backgroundColor") as HTMLInputElement | null;

export const initializeColorPicker = ({
    fontColorButton,
    fontColorInput,
    fontColorPreview,
    backgroundColorButton,
    backgroundColorInput,
    backgroundColorPreview
}: {
    fontColorButton: HTMLElement,
    fontColorInput: HTMLInputElement,
    fontColorPreview: HTMLElement,
    backgroundColorButton: HTMLElement,
    backgroundColorInput: HTMLInputElement,
    backgroundColorPreview: HTMLElement
}) => {
    if (fontColorButton && fontColorInput && fontColorPreview) {
        new Picker({
            parent: fontColorButton,
            popup: 'right',
            color: fontColorInput.value || '#000',
            onChange: (color) => {
                fontColorInput.value = color.hex;
                fontColorPreview.style.backgroundColor = color.hex;
            }
        });
    } else {
        console.warn("Font color elements are missing.");
    }

    if (backgroundColorButton && backgroundColorInput && backgroundColorPreview) {
        new Picker({
            parent: backgroundColorButton,
            popup: 'right',
            color: backgroundColorInput.value || '#f0f0f0',
            onChange: (color) => {
                backgroundColorInput.value = color.hex;
                backgroundColorPreview.style.backgroundColor = color.hex;
            }
        });
    } else {
        console.warn("Background color elements are missing.");
    }
};

export const getConfiguration = () => {
    return {
        fontColor: fontColorInput?.value || "#000",
        backgroundColor: backgroundColorInput?.value || "#f0f0f0"
    };
};