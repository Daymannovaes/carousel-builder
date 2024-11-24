import { beforeEach, describe, expect, it } from 'vitest';
import { createListItem, createListItems } from '../src/utils/create-list-items';

describe('createListItem', () => {
    let displayText: HTMLElement;

    beforeEach(() => {
        // Reset the DOM for each test
        document.body.innerHTML = '<div id="displayText"></div>';
        displayText = document.getElementById('displayText')!;
    });

    it('should create a list item with the provided text and style', () => {
        const text = 'Hello, world!';
        const style = { fontColor: '#000', backgroundColor: '#f0f0f0' };
        const listItem = createListItem(text, style);

        expect(listItem.textContent).toBe(text);
        displayText.appendChild(listItem);
        expect(displayText.contains(listItem)).toBe(true);
        expect(listItem.getAttribute('fontColor')).toBe(style.fontColor);
        expect(listItem.getAttribute('backgroundColor')).toBe(style.backgroundColor);
    });
});

describe('createListItems', () => {
    beforeEach(() => {
        // Reset the DOM for each test
        document.body.innerHTML = '<div id="displayText"></div>';
    });

    it('should create a list of list items with the provided text and style and append them to the displayText element', () => {
        const displayText = document.getElementById('displayText')!;
        const text = ['Hello, world! This is a test.', 'This is another test.'];
        const style = { fontColor: '#000', backgroundColor: '#f0f0f0' };

        createListItems(text, style, displayText);

        expect(displayText.innerHTML).not.toBe('');

        const ul = displayText.querySelector('ul');
        expect(ul).not.toBeNull();
        expect(ul!.classList.contains('carousel')).toBe(true);

        const slides = ul!.querySelectorAll('carousel-slide');
        expect(slides.length).toBe(text.length);
        slides.forEach((slide, index) => {
            expect(slide.getAttribute('backgroundColor')).toBe(style.backgroundColor);
            expect(slide.getAttribute('fontColor')).toBe(style.fontColor);
            expect(slide.textContent).toBe(text[index]);
        });
    });
});
