function rot13(str) {
  let result = [];
  let c;
  for (let i = 0; i < str.length; i++){
    c = str.charCodeAt(i);
    if (c >= 65 && c <=90){
      if (c + 13 <= 90){
        c = c + 13;
      }else{
        c = c + 12 - 90 + 65;
      }
      result.push(String.fromCharCode(c));
    }else{
      result.push(str.charAt(i));
    }
  }
  return result.join('');
}

console.log(rot13("SERR PBQR PNZC"));
