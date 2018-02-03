function toggleChildren(id){
  return function(){
    let details = document.getElementById(id);
    let className = (details.classList.contains("hide") ? "display" : "hide");
    details.className = className;
  };
}

function toggleDescendents(id){
  return function(){
    let details = document.getElementById(id);
    let className = (details.classList.contains("hide") ? "display" : "hide");
    recursiveToggler(details, className);
  };
}

function recursiveToggler(element, className){
  if(element.classList.contains("hide")||element.classList.contains("display")){
    element.className = className;
  }
  let children = element.children;
  for(let i = 0; i < children.length; i++){
    let child = children[i];
      recursiveToggler(child, className);
  }
}

function addListenersToType(type, listener){
  let list = document.getElementsByClassName(type);
  for (let i = 0; i < list.length; i++){
    let element = list[i];
    let tag = element.classList[1];
    element.addEventListener("click", listener(tag));
  }
}

document.addEventListener("DOMContentLoaded", () =>{
  addListenersToType("first-button", toggleChildren);
  addListenersToType("second-button", toggleDescendents);
});
