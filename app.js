"use strict";
const alertBox = document.getElementsByClassName("alertMaster")[0];
const master = document.getElementsByClassName("master")[0];
function toggleAlert(){
    if(alertBox.style.display === "none"){
        alertBox.style.display = "flex";
    }
    else alertBox.style.display = "none";
}


function trashEvent(eventid){
    const urlencode = `status=yes&eventid=${eventid}`;

    fetch("http://localhost:8000/superclub/newevent",{
        method:"POST",
        headers:{
            'content-type': 'application/x-www-form-urlencoded'
        },
        body: encodeURI(urlencode)
    })
    .then((res)=>{
        console.log("Event "+ eventid +" deleted successfully");
        window.location.reload();
    });
    
}