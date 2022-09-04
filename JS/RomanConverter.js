function convertToRoman(num) {
 let romans = ["M", "CM", "D", "CD", "C", "XC", "L", "XL", "X", "IX", "V", "IV", "I"];
 let values = [1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1];
 const result = [];
 for (let i = 0; i < romans.length; i++){
   while (num >= values[i]){
    result.push(romans[i]);
    num -= values[i];
   }
 }
 return result.join('');
}

console.log(convertToRoman(36));
