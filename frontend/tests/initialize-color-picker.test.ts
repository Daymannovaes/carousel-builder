import { describe, it, expect } from 'vitest';
import { initializeColorPicker } from '../src/settings';
import Picker from 'vanilla-picker';
import { vi } from 'vitest';

vi.mock('vanilla-picker'); // Mock the Picker library

describe('initializeColorPicker', () => {
    it('should initialize color pickers with the provided DOM elements', () => {
        const fontColorButton = document.createElement('button');
        const fontColorInput = document.createElement('input');
        const fontColorPreview = document.createElement('div');
        const backgroundColorButton = document.createElement('button');
        const backgroundColorInput = document.createElement('input');
        const backgroundColorPreview = document.createElement('div');

        initializeColorPicker({
            fontColorButton,
            fontColorInput,
            fontColorPreview,
            backgroundColorButton,
            backgroundColorInput,
            backgroundColorPreview
        });

        expect(Picker).toHaveBeenCalledWith({
            parent: fontColorButton,
            popup: 'right',
            color: fontColorInput.value || '#000',
            onChange: expect.any(Function)
        });

        expect(Picker).toHaveBeenCalledWith({
            parent: backgroundColorButton,
            popup: 'right',
            color: backgroundColorInput.value || '#f0f0f0',
            onChange: expect.any(Function)
        });

        expect(Picker).toHaveBeenCalledTimes(2);
    })

    it('should log a warning if any of the DOM elements are missing', () => {
        const consoleWarnSpy = vi.spyOn(console, 'warn').mockImplementation(() => { });

        initializeColorPicker({
            fontColorButton: null as unknown as HTMLElement, // Simulate missing elements
            fontColorInput: null as unknown as HTMLInputElement,
            fontColorPreview: null as unknown as HTMLElement,
            backgroundColorButton: null as unknown as HTMLElement,
            backgroundColorInput: null as unknown as HTMLInputElement,
            backgroundColorPreview: null as unknown as HTMLElement
        });

        expect(consoleWarnSpy).toHaveBeenCalledWith('Font color elements are missing.');
        expect(consoleWarnSpy).toHaveBeenCalledWith('Background color elements are missing.');
        expect(consoleWarnSpy).toHaveBeenCalledTimes(2);

        consoleWarnSpy.mockRestore();
    });
});