function addInputToListField(fieldId) {
    var div = document.getElementById(fieldId)
    var input = document.createElement("input");
    input.name = "tags[" + (div.childElementCount) + "]";
    input.classList.add("input");
    input.classList.add("input-sm");
    input.classList.add("autoresize");
    div.appendChild(input);
    div.appendChild(document.createTextNode("&emsp;"));
}

function removeInputFromListField(fieldId) {
    var div = document.getElementById(fieldId)
    div.removeChild(div.lastElementChild);
}

// (no-jquery document.ready)
function onReady(f) {
    "complete" === document.readyState ? f() : setTimeout(onReady, 10, f);
}

onReady(function() {
    [].forEach.call(
        document.querySelectorAll("input.autoresize"),
        registerInput
    );
});

function registerInput(el) {
    el.size = 1;
    var style = el.currentStyle || window.getComputedStyle(el),
        borderBox = style.boxSizing === "border-box",
        boxSizing = borderBox
            ? parseInt(style.borderRightWidth, 10) +
                parseInt(style.borderLeftWidth, 10)
            : 0;
    if ("onpropertychange" in el) {
         // IE
         el.onpropertychange = adjust;
    } else if ("oninput" in el) {
         el.oninput = adjust;
    }
    adjust();

    function adjust() {

        // reset to smaller size (for if text deleted) 
        el.style.width = "";

        // getting the scrollWidth should trigger a reflow
        // and give you what the width would be in px if 
        // original style, less any box-sizing
        var newWidth = el.scrollWidth + boxSizing;

        // so let's set this to the new width!
        el.style.width = newWidth + "px";
    }
}