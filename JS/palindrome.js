function palindrome(str) {
  let reg = /[\s.,\/#!$%\^&\*;:{}=\-_`~()]/g;
  let pal = str.replace(reg, "").toLowerCase();
  console.log(pal)
  for (let i = 0; i < pal.length / 2; i++){
    if (pal.charAt(i) != pal.charAt(pal.length - 1 - i)){
      return false;
    }
  }
  return true;
}

palindrome("eye");
