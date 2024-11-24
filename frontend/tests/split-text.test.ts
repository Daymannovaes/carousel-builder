import { describe, it, expect } from 'vitest';
import { splitText } from '../src/utils/split-text';

describe('splitText', () => {
    it('should split text into chunks of 50 words or less', () => {
        const text = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque eget nisi non diam molestie sodales. Vestibulum tristique, ante at placerat rhoncus, mauris leo feugiat metus, quis ullamcorper enim felis id erat. Donec nec dignissim metus. Ut mauris justo, hendrerit eu dolor id, ullamcorper lacinia odio. Proin finibus dignissim tellus, eget tempor lectus congue sed. Etiam lobortis, nunc non semper laoreet, ex urna euismod magna, id consectetur elit ex nec tortor. Quisque diam nulla, pharetra id tempor quis, malesuada in massa. Aliquam sit amet gravida ante, quis placerat tortor. Pellentesque facilisis augue sed justo malesuada tristique. Praesent accumsan, erat eu euismod.';
        const result: string[] = splitText(text);
        expect(result.length).toBeGreaterThan(1); // Expect more than one chunk
        expect(result[0].split(' ').length).toBeLessThanOrEqual(50); // Each chunk should have <= 50 words
        expect(result[result.length - 1].split(' ').length).toBeLessThanOrEqual(50); // Last chunk should also have <= 50 words
    });

    it('should throw an error for words longer than 300 characters', () => {
        const longWord = 'a'.repeat(301);
        const text = `Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque eget nisi non diam molestie sodales. Vestibulum tristique, ante at placerat rhoncus, mauris leo feugiat metus, quis ullamcorper enim felis id erat. Donec nec dignissim metus. Ut mauris justo, hendrerit eu dolor id, ullamcorper lacinia odio. Proin finibus dignissim tellus, eget tempor lectus congue sed. Etiam lobortis, nunc non semper laoreet, ex urna euismod magna, id consectetur elit ex nec tortor. Quisque diam nulla, pharetra id tempor quis, malesuada in massa. Aliquam sit amet gravida ante, quis placerat tortor. Pellentesque facilisis augue sed justo malesuada tristique. Praesent accumsan, erat eu euismod. ${longWord}`;
        expect(() => splitText(text)).toThrowError(
            new RegExp(`Erro: A palavra '${longWord}' tem mais de 300 caracteres.`)
        );
    });
})

