var curr = [
  ["PENNY", 0.01] ,
  ["NICKEL", 0.05],
  ["DIME" , 0.1],
  ["QUARTER" ,	0.25],
  ["ONE" ,	1],
  ["FIVE" , 5],
  ["TEN" ,	10],
  ["TWENTY" , 20],
  ["ONE HUNDRED" ,	100]
];

function checkCashRegister(price, cash, cid) {
  let changes = [];
  let ch;
  let amount = cash - price;
  for (let i = cid.length - 1; i >= 0; i--){
    if (cid[i][1] == 0){
      continue;
    }else if (amount == 0){
       break;
    }else if (amount >= cid[i][1]){
        amount = Number((amount - cid[i][1]).toFixed(2));
        changes.push([cid[i][0], cid[i][1]]);
    }else if(amount < cid[i][1]){
        ch = Math.floor(amount/curr[i][1]);
        if (ch > 0 && curr[i][1] <= amount){
          for (let j = 0; j < ch; j++){
            amount = Number((amount - curr[i][1]).toFixed(2));
          }
          changes.push([cid[i][0], ch*curr[i][1]]);
        }
    }
  }
  let sum = 0;
  for (let i = 0; i < cid.length; i++){
    sum += cid[i][1];
  }
  console.log(changes);
  if (amount > 0){
    return {"status": "INSUFFICIENT_FUNDS", "change": []};
  }else if (amount == 0 && sum == cash - price){
    return {"status": "CLOSED", "change": cid};
  }else{
    return {"status": "OPEN", "change":changes};
  }
}

console.log(  checkCashRegister(3.26, 100, [["PENNY", 1.01], ["NICKEL", 2.05], ["DIME", 3.1], ["QUARTER", 4.25], ["ONE", 90], ["FIVE", 55], ["TEN", 20], ["TWENTY", 60], ["ONE HUNDRED", 100]]));
