export const splitText = (text: string) => {
    const words = text.split(" ");
    const resultingText = [];
    let currentText = "";

    for (let i = 0; i < words.length; i++) {
        if (words[i].length > 300) {
            throw new Error("Erro: A palavra '" + words[i] + "' tem mais de 300 caracteres.");
        }

        currentText += words[i] + " ";

        if (currentText.split(" ").length > 50 || currentText.length > 300) {
            resultingText.push(currentText.trim());
            currentText = "";
        }
    }

    if (currentText) {
        resultingText.push(currentText.trim());
    }

    return resultingText;
};