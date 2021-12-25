namespace Zeller {
  static double calculate_day(uint16 day,uint16 month , uint16 year){
    if (month==1||month==2){
      year=year-1;
      month = month+12;
    }
    uint8 k = year%100;
    uint8 j = year/100;
    double result = (2.6*(month+1))+(k/4)+(j/4)+day+k-2*j; 
    result = result%7;
    return (int)result;
  }
}
/* public static int main (string[] args) {
  stdout.printf("%g",calculate_day(28,1,2022));
  return 0;
} */

/* int main (string[] args) {
  stdout.printf(new DateTime.now_local().format("%d-%m-%y and now the current time is %I:%M%p"));
  return 0;
} */
