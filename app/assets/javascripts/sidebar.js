function openSideBar(id) {
    console.log(id);
    document.getElementById(id).style.width = "250px";
}

function closeSideBar(id) {
    document.getElementById(id).style.width = "0px";
}