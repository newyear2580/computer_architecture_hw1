#include<stdio.h>
void swap(int res[34], int temp[34]) {
  int a ;
  for ( int i = 0 ; i < 34 ; i ++ ) {
    a = res[i] ;
    res[i] = temp[i] ;
    temp[i] = a ;
  } // for
} // swap

int main() {
  int result[34] = {0} ;
  int temp[34] = {0} ;
  int rowIndex = 5 ;
  int limit = 33 ;
  if ( rowIndex < 0 || rowIndex > 33 ) { // error
    printf("Input is out of range!\n") ;
    return ;
  } // if
  else if ( rowIndex == 0 ) {
    result[0] = 1 ;
  } // else if
  else if ( rowIndex == 1 ) {
    result[0] = 1 ;
    result[1] = 1 ;
  } // else if
  else {  // rowIndex > 1
    result[0] = 1 ;
    result[1] = 1 ;
    for ( int i = 2 ; i <= rowIndex ; i ++ ) {
      temp[0] = 1 ;
      for ( int j = 1 ; j < i ; j ++ ) {
        temp[j] = result[j-1] + result[j] ;
      } // for
      temp[i] = 1 ;
      swap(result, temp) ;
    } // for
  } // else

  printf("[%d", result[0]) ;
  for ( int k = 1 ; k <= rowIndex ; k ++ ) {
    printf(",%d", result[k]) ;
  } // for
  printf("]\n") ;
} // main()
