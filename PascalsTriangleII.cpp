vector<int> getRow(int rowIndex) {
  vector<int> result ;
  if ( rowIndex == 0 ) {
    result = { 1 } ;
    return result ;
  } // if
  else if ( rowIndex == 1 ) {
    result = { 1, 1 } ;
    return result ;
  } // else if
  else {  // rowIndex > 1
    vector<int> temp ;
    result = { 1, 1 } ;
    for ( int i = 2 ; i <= rowIndex ; i ++ ) {
      temp.push_back( 1 ) ;
      for ( int j = 1 ; j < result.size() ; j ++ ) {
        temp.push_back( result[j - 1] + result[j] ) ;
      } // for
      temp.push_back( 1 ) ;
      result = temp ;
      temp.clear() ;
    } // for
    return result ;
  } // else
}
