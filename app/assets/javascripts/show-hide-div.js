function toggleElementDisplay(id) {
    var element = document.getElementById(id);
    if (element.style.display == "none") {
        element.style.display = "block";
        element.style.visibility = "visible";
    } else {
        element.style.display = "none";
        element.style.visibility = "hidden";
    }
    return element;
}