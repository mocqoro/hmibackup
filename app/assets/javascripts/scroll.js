function scrollToAnchor(hashName) {
    console.log(hashName);
    if (hashName != "") {
        window.location.hash = "#" + hashName;   
    }
}

function test() {
    alert(window.location.hash);
    if (window.location.hash) {
        var hash = window.location.hash;
        window.location.hash = "";
        window.location.hash = hash;
    }
}