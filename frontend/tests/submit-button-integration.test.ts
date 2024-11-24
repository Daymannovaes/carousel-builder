import { describe, it, beforeEach, expect, vi } from "vitest";
import { createListItems } from "../src/utils/create-list-items";
import { splitText } from "../src/utils/split-text";
import { getConfiguration } from "../src/settings";

// Mock dependencies
vi.mock("../src/utils/create-list-items");
vi.mock("../src/utils/split-text");
vi.mock("../src/settings");

let submitButton: HTMLElement;
let textInput: HTMLInputElement;
let displayText: HTMLElement;

describe("Main flow integration tests", () => {
    beforeEach(async () => {
        vi.clearAllMocks(); // Added to reset all mocks before each test

        // Set up DOM before importing src/index.ts
        document.body.innerHTML = `
            <input id="textInput" />
            <button id="submitButton">Submit</button>
            <div id="displayText"></div>
            <p id="charCounter"></p>
            <div id="errorMessage"></div>
        `;

        submitButton = document.getElementById("submitButton")!;
        textInput = document.getElementById("textInput") as HTMLInputElement;
        displayText = document.getElementById("displayText")!;

        // Reset modules and import the main script
        vi.resetModules();
        await import("../src/index");
    });

    it("should call all components correctly on submit", () => {
        const mockSplitItems = ["Item 1", "Item 2"];
        const mockConfig = { fontColor: "#000", backgroundColor: "#fff" };

        // Mock function behaviors
        (vi.mocked(splitText)).mockReturnValue(mockSplitItems);
        (vi.mocked(getConfiguration)).mockReturnValue(mockConfig);

        // Simulate user input
        textInput.value = "Test text.";
        submitButton.click();

        expect(splitText).toHaveBeenCalledWith("Test text.");
        expect(getConfiguration).toHaveBeenCalled();
        expect(createListItems).toHaveBeenCalledWith(mockSplitItems, mockConfig, displayText);
    });

    it("should not call createListItems when input is empty", () => {
        textInput.value = ""; // Empty input
        submitButton.click();

        expect(splitText).not.toHaveBeenCalled();
        expect(getConfiguration).not.toHaveBeenCalled();
        expect(createListItems).not.toHaveBeenCalled();
    });
});