function calculation (){
  const calc  = document.getElementById("item-price");
  calc.addEventListener("keyup", () => {
    const item_price = calc.value;
    const profit  = document.getElementById("profit");
    const add_tax_price  = document.getElementById("add-tax-price");


    add_tax_price.innerHTML = Math.floor(`${item_price*0.1}`);
    profit.innerHTML =Math.floor(`${item_price*0.9}`);
  });
};

window.addEventListener('load', calculation);
