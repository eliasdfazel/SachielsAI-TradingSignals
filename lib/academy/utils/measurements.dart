/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 12/12/22, 4:54 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

double gridHeight(int initialHeight, int dataCount, int columnCount) {

  double heightResult = 1;

  heightResult = (initialHeight * (dataCount / columnCount).round()).toDouble();

  return heightResult;
}