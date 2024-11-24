import { describe, it, beforeEach, expect } from 'vitest';
import { CarouselSlide } from '../src/carousel-slide';

customElements.define('carousel-slide', CarouselSlide);

describe('CarouselSlide', () => {
    let carouselSlide: CarouselSlide;

    beforeEach(() => {
        carouselSlide = new CarouselSlide();
    });

    it('should create carousel slide element', () => {
        expect(carouselSlide).toBeInstanceOf(CarouselSlide);
    });

    it('should have shadow root', () => {
        expect(carouselSlide.shadowRoot).not.toBeNull();
    });

    it('should contain carousel-slide class in container', () => {
        const container = carouselSlide.shadowRoot?.querySelector('.carousel-slide');
        expect(container).not.toBeNull();
    });

    it('should have correct styles applied', () => {
        const style = carouselSlide.shadowRoot?.querySelector('style');
        expect(style).not.toBeNull();
    });
});