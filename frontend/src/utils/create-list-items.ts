export const createListItem = (
    item: string,
    { fontColor, backgroundColor }: { fontColor: string, backgroundColor: string }
) => {
    const listItem = document.createElement("carousel-slide");
    listItem.setAttribute('backgroundColor', backgroundColor);
    listItem.setAttribute('fontColor', fontColor);

    listItem.style.color = fontColor;
    listItem.style.backgroundColor = backgroundColor;

    listItem.textContent = item;

    return listItem;
};

export const createListItems = (
    items: string[],
    { fontColor, backgroundColor }: { fontColor: string; backgroundColor: string },
    displayText: HTMLElement
) => {
    displayText.innerHTML = '';
    const ul = document.createElement('ul');
    ul.classList.add('carousel');

    items.forEach((item) => {
        const listItem = createListItem(item, { fontColor, backgroundColor });
        ul.appendChild(listItem);
    });

    displayText.appendChild(ul);
};