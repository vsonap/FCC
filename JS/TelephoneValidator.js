function telephoneCheck(str) {
  let f = "?!@#$%^&*-";
  let result = true;
  let digits = str.match(/\d/g);
  let symb = str.split('');
  let left = symb.filter(item => item == '(');
  let right = symb.filter(item => item == ')');
  if (!left.length && !right.length){
    result = true;
  }else{
    result = left.length == right.length;
  }
  result = result && !(symb.filter(e => "?!@#$%^&*".includes(e)).length > 0);
  result = result && (symb.filter(e => e == '-').length <= 2)
  result = result && (!f.includes(symb[0]));
  result = result && (digits.length===10 || digits.length===11);
  result = result && (digits[0] == 5 || digits[0] == 1);

  return result;
}

telephoneCheck("(555)555-5555");
